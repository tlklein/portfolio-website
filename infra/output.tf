output "bucket_name" {
  value = aws_s3_bucket.resume_bucket.bucket
  description = "The name of the S3 bucket hosting the resume site"
}

output "dynamodb_table" {
  value       = aws_dynamodb_table.visitor_counter.name
  description = "DynamoDB table name used for visitor counter"
}

output "static_website_url" {
  value = aws_s3_bucket_website_configuration.static_site.website_endpoint
  description = "S3 static website endpoint name"
}

output "cloudfront_url" {
  value       = aws_cloudfront_distribution.resume_distribution.domain_name
  description = "CloudFront distribution domain name"
}

output "lambda_function_name" {
  value       = aws_lambda_function.visitor_counter.function_name
  description = "Lambda function name for the visitor counter"
}

output "api_gateway_url" {
  value       = aws_apigatewayv2_api.visitor_api.api_endpoint
  description = "API Gateway URL for visitor counter"
}

# NO DOMAIN YET
# output "route53_zone_id" {
#  value       = aws_route53_zone.main.zone_id
#  description = "Route 53 zone ID"
# }
