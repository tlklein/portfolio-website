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
  alias  = "test"
  region = "us-east-2"
  profile = "tlklein-test"
}

#######################################################
# Route53 Zone Data Source
#######################################################
data "aws_route53_zone" "primary" {
  name         = "trinityklein.dev."
  private_zone = false
}

#######################################################
# Route53 Validation Records
#######################################################
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = "www.trinityklein.dev"
  type    = "A"

  alias {
    name                   = module.cloudfront.domain_name
    zone_id                = module.cloudfront.hosted_zone_id
    evaluate_target_health = false
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [alias]
  }
}
