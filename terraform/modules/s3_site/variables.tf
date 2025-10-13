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
# If versioning is enabled
#######################################################
variable "versioning" {
  type        = bool
  description = "If versioning is enabled or not"
}

#######################################################
# Current Environment
#######################################################
variable "environment" {
  description = "default environment name"
  type        = string
}

#######################################################
# File Types
#######################################################
variable "mime_types" {
  type    = map(string)
  default = {}
}

#######################################################
# Project Tags
#######################################################
variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
}

#######################################################
# CloudFront ARN String
#######################################################
variable "cloudfront_arn" {
  description = "Optional CloudFront distribution ARN for S3 access policy"
  type        = string
}