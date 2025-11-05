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
  test_sso_arn   = var.test_sso_arn
}

#######################################################
# CloudFront Module
#######################################################
module "cloudfront" {
  source                 = "./modules/cloudfront"
  origin_bucket          = var.origin_bucket
  project_prefix         = var.project_prefix
  environment            = var.environment
  domain_name = var.domain_name
  cloudfront_zone_id     = var.cloudfront_zone_id
  cloudfront_domain_name = var.cloudfront_domain_name
  cloudfront_arn = module.cloudfront.distribution_arn
  acm_certificate_arn    = var.acm_certificate_arn
  existing_oac_name      = var.existing_oac_name
  existing_oac_id        = var.existing_oac_id
  tags                   = local.common_tags
  root_profile           = var.root_profile
  test_profile           = var.test_profile
  test_sso_arn           = var.test_sso_arn
  region = var.region
  origin_bucket_domain_name = var.origin_bucket_domain_name
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
module "api" {
  source              = "./modules/api"
  project_prefix      = var.project_prefix
  function_name       = "${var.project_prefix}-${var.environment}-visitor"
  filename            = "modules/lambda/visitor-counter"
  environment         = var.environment
  region              = var.region
  handler             = var.handler
  runtime             = var.runtime
  dynamodb_table_name = var.dynamodb_table_name
}

#######################################################
# DNS Module
#######################################################
module "dns" {
  source             = "./modules/dns"
  domain_name        = var.domain_name
  cloudfront_zone_id = var.cloudfront_zone_id
}
