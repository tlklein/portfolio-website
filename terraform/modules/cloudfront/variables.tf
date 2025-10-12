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
# S3 Bucket Name
#######################################################
variable "origin_bucket" {
  description = "S3 bucket to serve as the CloudFront origin"
  type        = string
}

#######################################################
# ACM certificate ARN for HTTPS support
#######################################################
variable "acm_certificate_arn" {
  description = "The ARN of the ACM certificate to use with CloudFront"
  type        = string
}

#######################################################
# CloudFront Zone ID
#######################################################
variable "cloudfront_zone_id" {
  type        = string
  description = "Optional CloudFront Hosted Zone ID for DNS records"
}
