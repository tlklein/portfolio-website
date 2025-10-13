###########################################################
# IAM policy document for Lambda trust
###########################################################
output "lambda_function_name" {
  description = "The name of the Lambda function"
  value       = aws_lambda_function.visitor.function_name
}

###########################################################
# API Endpoint 
###########################################################
output "api_endpoint" {
  description = "The HTTP API endpoint"
  value       = aws_apigatewayv2_api.http_api.api_endpoint
}

###########################################################
# IAM policy document for Lambda trust
###########################################################
output "lambda_arn" {
  description = "ARN of the Lambda function"
  value       = aws_lambda_function.visitor.arn
}

###########################################################
# IAM policy document for Lambda trust
###########################################################
output "lambda_role_arn" {
  description = "ARN of the Lambda execution role"
  value       = aws_iam_role.lambda_exec.arn
}

###########################################################
# Visitor API  URL
###########################################################
output "visitor_api_url" {
  value = aws_apigatewayv2_stage.default.invoke_url
}