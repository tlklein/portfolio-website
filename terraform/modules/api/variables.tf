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
  description = "default environment name"
  type        = string
}

#######################################################
# Default AWS region
#######################################################
variable "region" {
  description = "AWS region to deploy resources"
  type        = string
}

#######################################################
# Lambda Handler
#######################################################
variable "handler" {
  type        = string
  description = "Lambda function handler"
}

#######################################################
# Lambda Runtime
#######################################################
variable "runtime" {
  type        = string
  description = "Lambda runtime"
}

#######################################################
# DynamoDB Table Name
#######################################################
variable "dynamodb_table_name" {
  type        = string
  description = "DynamoDB table name for visitor counter"
}

#######################################################
# Lambda Code File Name 
#######################################################
variable "filename" {
  type        = string
  description = "file name for lambda code"
}

#######################################################
# Lambda Code Function Name
#######################################################
variable "function_name" {
  type        = string
  description = "file name for lambda code"
}
