#######################################################
# DynamoDB Table Name
#######################################################
output "table_name" {
  value       = aws_dynamodb_table.visitor.name
  description = "The name of the DynamoDB table"
}

#######################################################
# DynamoDB Table ARN
#######################################################
output "table_arn" {
  value       = aws_dynamodb_table.visitor.arn
  description = "The name of the DynamoDB table"
}
