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
# Current Environment
#######################################################
variable "environment" {
  default     = "prod"
  description = "default enviornment name"
  type        = string
}

#######################################################
# Project Tags
#######################################################
variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}