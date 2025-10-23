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

#######################################################
# Input Data 
#######################################################
variable "visitors" {
  description = "Map of visitor items to insert into the DynamoDB table"
  type = map(object({
    ip_address  = string
    first_visit = number
    last_visit  = number
    visit_count = number
  }))
}
