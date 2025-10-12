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

#######################################################
# DynamoDB Table Billing Mode
#######################################################
output "billing_mode" {
  value       = aws_dynamodb_table.visitor.billing_mode
  description = "Billing mode used for this DynamoDB table (PAY_PER_REQUEST or PROVISIONED)"
}