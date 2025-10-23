#######################################################
# Website domain name
#######################################################
variable "domain_name" {
  type        = string
  description = "The Route53 domain"
}

#######################################################
# Website sub domain name
#######################################################
variable "subdomain" {
  type        = list(string)
  description = "Optional subdomains for the certificate"
}

#######################################################
# Project prefix to apply to all resources
#######################################################
variable "project_prefix" {
  description = "Prefix to identify all resources for this project"
  type        = string
}

#######################################################
# S3 Bucket Name
#######################################################
variable "bucket_name" {
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
# Root Profile Name
#######################################################
variable "root_profile" {
  description = "AWS CLI profile for the root account"
  type        = string
}

#######################################################
# Test Profile Name
#######################################################
variable "test_profile" {
  description = "AWS CLI profile for the test account"
  type        = string
}

#######################################################
# Terraform role arn for root
#######################################################
variable "root_role_arn" {
  description = "ARN of the IAM role for root account"
  type        = string
}

#######################################################
# Terraform role arn for test
#######################################################
variable "test_role_arn" {
  description = "ARN of the IAM role for root account"
  type        = string
}

#######################################################
# Terraform test account sso arn
#######################################################
variable "test_sso_arn" {
  description = "ARN of the IAM role for root account"
  type        = string
}

#######################################################
# Dynamodb table arn for state lock table
#######################################################
variable "dynamodb_arn" {
  description = "ARN for dynamodb table for state locking"
  type        = string
}

#######################################################
# S3 bucket table arn main
#######################################################
variable "s3_arn" {
  description = "ARN for main S3 bucket"
  type        = string
}

#######################################################
# S3 bucket table arn to allow change files main
#######################################################
variable "s3_arn_files" {
  description = "ARN for main S3 bucket to allow change files"
  type        = string
}

#######################################################
# S3 bucket table arn for state locking 
#######################################################
variable "s3_state_arn" {
  description = "ARN for S3 bucket for state locking"
  type        = string
}

#######################################################
# S3 bucket table arn for state locking allow change files 
#######################################################
variable "s3_state_files" {
  description = "ARN for S3 bucket to allow change files in state lock"
  type        = string
}

#######################################################
# Dynamodb tf state table
#######################################################
variable "tfstate_bucket_name" {
  description = "TF state bucket name"
  type        = string
}

#######################################################
# Dynamodb tf state table key
#######################################################
variable "tfstate_bucket_key" {
  description = "TF state bucket key"
  type        = string
}

#######################################################
# File Types
#######################################################
variable "mime_types" {
  type = map(string)
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
# Lambda S3 Bucket Name
#######################################################
variable "lambda_s3_bucket" {
  type        = string
  description = "S3 bucket where the Lambda zip is stored"
}

#######################################################
# DynamoDB Table NAme in APi
#######################################################
variable "dynamodb_table_name" {
  type        = string
  description = "DynamoDB table name for visitor counter"
}

#######################################################
# CloudFront Zone ID
#######################################################
variable "cloudfront_zone_id" {
  description = "The Route53 Hosted Zone ID for the CloudFront distribution"
  type        = string
}

#######################################################
# Database billing mode
#######################################################
variable "billing_mode" {
  description = "Billing mode: PROVISIONED or PAY_PER_REQUEST"
  type        = string
}

#######################################################
# DynamoDB Table Name in DB
#######################################################
variable "table_name" {
  type        = string
  description = "The name of the Dynamodb table"
}

#######################################################
# If versioning is enabled
#######################################################
variable "versioning" {
  type        = bool
  description = "If versioning is enabled or not"
}

#######################################################
# Project Tags
#######################################################
variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
}

#######################################################
# S3 Origin Bucket Name
#######################################################
variable "origin_bucket" {
  description = "The name of the S3 bucket that serves as the origin"
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

#######################################################
# ACM Certificate ARN
#######################################################
variable "acm_certificate_arn" {
  description = "ACM certificate ARN to use for CloudFront"
  type        = string
}
