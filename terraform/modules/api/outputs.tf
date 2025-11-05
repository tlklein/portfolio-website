output "api_endpoint" {
  description = "Public endpoint for the visitor counter API"
  value       = aws_apigatewayv2_api.http_api.api_endpoint
}
