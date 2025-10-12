#######################################################
# DynamoDB Table Name
#######################################################
variable "table_name" {
  type        = string
  description = "The name of the Dynamodb table"
}

#######################################################
# Database billing mode
#######################################################
variable "billing_mode" {
  description = "Billing mode: PROVISIONED or PAY_PER_REQUEST"
  type        = string
}

#######################################################
# Project prefix to apply to all resources
#######################################################
variable "project_prefix" {
  description = "Prefix to identify all resources for this project"
  type        = string
}


#######################################################
# Current Environment
#######################################################
variable "environment" {
  description = "default enviornment name"
  type        = string
}