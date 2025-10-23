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
# Fetch Route53 zone
#######################################################
data "aws_route53_zone" "primary" {
  name         = "trinityklein.dev."
  private_zone = false
}

#######################################################
# State Bucket Module
#######################################################
data "terraform_remote_state" "global" {
  backend = "s3"
  config = {
    bucket       = "tlklein-portfolio-tf-state"
    key          = "state/terraform.tfstate"
    region       = "us-east-2"
    encrypt      = true
    use_lockfile = true
    profile      = "tlklein-test"
  }
}

#######################################################
# S3 Module
#######################################################
module "s3_site" {
  source         = "./modules/s3_site"
  bucket_name    = var.bucket_name
  environment    = var.environment
  versioning     = var.versioning
  mime_types     = var.mime_types
  tags           = local.common_tags
  cloudfront_arn = module.cloudfront.distribution_arn
  project_prefix = var.project_prefix
}

#######################################################
# CloudFront Module
#######################################################
module "cloudfront" {
  source              = "./modules/cloudfront"
  origin_bucket       = module.s3_site.bucket_name
  project_prefix      = var.project_prefix
  environment         = var.environment
  cloudfront_zone_id  = var.cloudfront_zone_id
  acm_certificate_arn = module.certificate.acm_certificate_arn
}

#######################################################
# Database Module
#######################################################
module "database" {
  source         = "./modules/database"
  table_name     = var.table_name
  environment    = var.environment
  project_prefix = var.project_prefix
  billing_mode   = var.billing_mode
  visitors = {
    visitor1 = {
      ip_address  = "192.168.1.1"
      first_visit = 1697890000
      last_visit  = 1697893600
      visit_count = 1
    }
    visitor2 = {
      ip_address  = "192.168.1.2"
      first_visit = 1697890200
      last_visit  = 1697893800
      visit_count = 3
    }
  }
}

#######################################################
# API Module
#######################################################
module "visitor_counter" {
  source              = "./modules/api"
  project_prefix      = var.project_prefix
  environment         = var.environment
  region              = var.region
  lambda_s3_bucket    = module.s3_site.bucket_name
  lambda_s3_key       = var.lambda_s3_key
  handler             = var.handler
  runtime             = var.runtime
  dynamodb_table_name = var.dynamodb_table_name
}

#######################################################
# ACM Certificate
#######################################################
module "certificate" {
  source             = "./modules/certificate"
  domain_name        = var.domain_name
  subdomain          = var.subdomain
  tags               = local.common_tags
  project_prefix     = var.project_prefix
  environment        = var.environment
  cloudfront_zone_id = var.cloudfront_zone_id
}

#######################################################
# DNS Module
#######################################################
module "dns" {
  source             = "./modules/dns"
  project_prefix     = var.project_prefix
  environment        = var.environment
  domain_name        = var.domain_name
  subdomain          = var.subdomain
  cloudfront_zone_id = var.cloudfront_zone_id
}
