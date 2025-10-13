#######################################################
# Locals
#######################################################
locals {
  common_tags = {
    Project     = var.project_prefix
    Environment = var.environment
    Owner       = "Trinity Klein"
    Purpose     = "Cloud Resume Challenge"
  }
}

#######################################################
# Provider
#######################################################
provider "aws" {
  alias  = "use1"
  region = "us-east-1"
}

#######################################################
# Route53 Data Source
#######################################################
data "aws_route53_zone" "primary" {
  name         = var.domain_name
  private_zone = false
}


#######################################################
# ACM Certificate
#######################################################
resource "aws_acm_certificate" "cloudfront_cert" {
  provider                  = aws.use1
  domain_name               = var.domain_name
  subject_alternative_names = length(var.subdomain) > 0 ? [for sub in var.subdomain : "${sub}.${var.domain_name}"] : []
  validation_method         = "DNS"
  tags                      = local.common_tags

  lifecycle {
    create_before_destroy = true
  }
}

#######################################################
# Create Each ACM Certificate
#######################################################
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cloudfront_cert.domain_validation_options : dvo.domain_name => dvo
  }

  zone_id = data.aws_route53_zone.primary.zone_id
  name    = each.value.resource_record_name
  type    = each.value.resource_record_type
  records = [each.value.resource_record_value]
  ttl     = 60
}

#######################################################
# Certificate Validation
#######################################################
resource "aws_acm_certificate_validation" "cloudfront_validation" {
  provider                = aws.use1
  certificate_arn         = aws_acm_certificate.cloudfront_cert.arn
  validation_record_fqdns = [for r in aws_route53_record.cert_validation : r.fqdn]

  depends_on = [aws_route53_record.cert_validation]
}
