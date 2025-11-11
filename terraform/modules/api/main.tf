###########################################################
# Locals
###########################################################
locals {
  common_tags = {
    Project     = var.project_prefix
    Environment = var.environment
    Owner       = "Trinity Klein"
    Purpose     = "Cloud Resume Challenge"
  }
}

###########################################################
# AWS Account Info
###########################################################
data "aws_caller_identity" "current" {}

###########################################################
# AWS Signer Profile for Lambda
###########################################################
resource "aws_signer_signing_profile" "lambda_profile" {
  name        = "${replace(var.project_prefix, "-", "")}${replace(var.environment, "-", "")}LambdaProfile"
  platform_id = "AWSLambda-SHA384-ECDSA"

  tags = local.common_tags
}

###########################################################
# Lambda Code Signing Configuration
###########################################################
resource "aws_lambda_code_signing_config" "lambda_signing_config" {
  allowed_publishers {
    signing_profile_version_arns = [
      aws_signer_signing_profile.lambda_profile.arn
    ]
  }

  policies {
    untrusted_artifact_on_deployment = "Enforce"
  }

  description = "Code signing enforcement for Lambda"
  tags        = local.common_tags
}

###########################################################
# IAM policy document for Lambda trust
###########################################################
data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

###########################################################
# IAM Role for Lambda Execution
###########################################################
resource "aws_iam_role" "lambda_exec" {
  name               = "${var.project_prefix}-${var.environment}-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
  tags               = local.common_tags
}

###########################################################
# Attach Inline Policy for DynamoDB + CloudWatch
###########################################################
resource "aws_iam_role_policy" "lambda_dynamodb_policy" {
  name = "${var.project_prefix}-${var.environment}-lambda-policy"
  role = aws_iam_role.lambda_exec.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:Scan",
          "dynamodb:Query"
        ],
        Effect   = "Allow",
        Resource = "arn:aws:dynamodb:${var.region}:${data.aws_caller_identity.current.account_id}:table/${var.dynamodb_table_name}"
      },
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}



###########################################################
# Lambda Function
###########################################################
resource "aws_lambda_function" "visitor" {
  function_name = "${var.project_prefix}-${var.environment}-visitor"
  filename      = "${path.module}/lambda/visitor-counter.zip"
  handler       = var.handler
  runtime       = var.runtime
  role          = aws_iam_role.lambda_exec.arn
  publish       = true

  environment {
    variables = {
      TABLE_NAME = var.dynamodb_table_name
      ENV        = var.environment
    }
  }

  tracing_config { mode = "Active" }
  tags = local.common_tags
}

###########################################################
# HTTP API Gateway (v2)
###########################################################
resource "aws_apigatewayv2_api" "http_api" {
  name          = "${var.project_prefix}-${var.environment}-api"
  protocol_type = "HTTP"
  tags          = local.common_tags

  cors_configuration {
    allow_origins     = ["*"]
  }
}

###########################################################
# Lambda Integration
###########################################################
resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id                 = aws_apigatewayv2_api.http_api.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.visitor.invoke_arn
  integration_method     = "POST"
  payload_format_version = "2.0"
}

###########################################################
# Route: ANY /visitors
###########################################################
resource "aws_apigatewayv2_route" "visitors" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "ANY /VisitorCounter"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

###########################################################
# Lambda Permission for API Gateway
###########################################################
resource "aws_lambda_permission" "apigw_invoke" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.visitor.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.http_api.execution_arn}/*/*"
}

###########################################################
# Default Stage (Auto Deploy)
###########################################################
resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.http_api.id
  name        = "$default"
  auto_deploy = true
  tags        = local.common_tags
}

