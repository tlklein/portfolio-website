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
# Lambda S3 Bucket Name
#######################################################
variable "lambda_s3_bucket" {
  type        = string
  description = "S3 bucket where the Lambda zip is stored"
}

#######################################################
# Lambda S3 Bucket Key
#######################################################
variable "lambda_s3_key" {
  type        = string
  description = "S3 key for Lambda zip file"
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
