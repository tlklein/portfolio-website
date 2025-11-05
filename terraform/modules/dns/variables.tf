#######################################################
# Website domain name
#######################################################
variable "domain_name" {
  type        = string
  description = "The Route53 domain"
}

#######################################################
# CloudFront Zone ID
#######################################################
variable "cloudfront_zone_id" {
  type        = string
  description = "Optional CloudFront Hosted Zone ID for DNS records"
}
