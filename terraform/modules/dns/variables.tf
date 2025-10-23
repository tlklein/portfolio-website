#######################################################
# Project prefix to apply to all resources
#######################################################
variable "project_prefix" {
  description = "Prefix to identify all resources for this project"
  type        = string
}

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
# Current Environment
#######################################################
variable "environment" {
  description = "default enviornment name"
  type        = string
}

#######################################################
# CloudFront Zone ID
#######################################################
variable "cloudfront_zone_id" {
  description = "The Route53 Hosted Zone ID for the CloudFront distribution"
  type        = string
}
