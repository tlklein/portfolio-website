#######################################################
# S3 Bucket Name
#######################################################
output "bucket_name" {
  value       = module.s3_site.bucket_name
  description = "The name of the S3 bucket hosting the resume site"
}

#######################################################
# CloudFront URL
#######################################################
output "cloudfront_url" {
  description = "CloudFront distribution domain name"
  value       = module.cloudfront.cloudfront_domain_name
}

#######################################################
# Visitor API URL
#######################################################
output "visitor_api_endpoint" {
  description = "Public API endpoint for visitor counter"
  value       = module.api.api_endpoint
}
