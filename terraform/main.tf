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
  name         = var.domain_name
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
  versioning     = true
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
  acm_certificate_arn = module.certificate.acm_certificate_arn
  project_prefix      = var.project_prefix
  environment         = var.environment
  cloudfront_zone_id  = var.cloudfront_zone_id
}

#######################################################
# Database Module
#######################################################
module "database" {
  source         = "./modules/database"
  table_name     = "v3-tlklein-portfolio-prod-visitor"
  environment    = var.environment
  project_prefix = var.project_prefix
  billing_mode   = var.billing_mode
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
  dynamodb_table_name = module.database.table_name
}

#######################################################
# ACM Certificate
#######################################################
module "certificate" {
  source         = "./modules/certificate"
  domain_name    = var.domain_name
  subdomain      = var.subdomain
  tags           = local.common_tags
  project_prefix = var.project_prefix
  environment    = var.environment
}

#######################################################
# DNS Module
#######################################################
module "dns" {
  source              = "./modules/dns"
  project_prefix      = var.project_prefix
  environment         = var.environment
  domain_name         = var.domain_name
  subdomain           = var.subdomain
  cloudfront_domain   = module.cloudfront.domain_name
  acm_certificate_arn = module.certificate.acm_certificate_arn
  cloudfront_zone_id  = var.cloudfront_zone_id
}
