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
# S3 Bucket Name
#######################################################
variable "origin_bucket" {
  description = "S3 bucket to serve as the CloudFront origin"
  type        = string
}

#######################################################
# S3 Bucket Name Domain Name
#######################################################
variable "origin_bucket_domain_name" {
  description = "S3 bucket domain name to serve as the CloudFront origin"
  type        = string
}

#######################################################
# CloudFront Zone ID
#######################################################
variable "cloudfront_zone_id" {
  type        = string
  description = "Optional CloudFront Hosted Zone ID for DNS records"
}

#######################################################
# CloudFront Domain Name
#######################################################
variable "cloudfront_domain_name" {
  description = "The Route53 Hosted Zone ID for the CloudFront distribution"
  type        = string
}

#######################################################
# ACM Certificate ARN
#######################################################
variable "acm_certificate_arn" {
  description = "ACM certificate ARN to use for CloudFront"
  type        = string
}

#######################################################
# Project Tags
#######################################################
variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
}

#######################################################
# Website domain name
#######################################################
variable "domain_name" {
  type        = string
  description = "The Route53 domain"
}

###########################################################
# Import CloudFront OAC Name
###########################################################
variable "existing_oac_name" {
  description = "Name of existing CloudFront OAC"
  type        = string
}

###########################################################
# Import CloudFront OAC ID
###########################################################
variable "existing_oac_id" {
  description = "The ID of the existing CloudFront Origin Access Control"
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
# CloudFront ARN String
#######################################################
variable "cloudfront_arn" {
  description = "Optional CloudFront distribution ARN for S3 access policy"
  type        = string
}
