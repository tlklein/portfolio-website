#######################################################
# S3 Bucket Name
#######################################################
output "bucket_name" {
  value       = module.s3_site.bucket_name
  description = "The name of the S3 bucket hosting the resume site"
}

#######################################################
# Static Website Endpoint URL
#######################################################
output "static_website_url" {
  value       = module.s3_site.bucket_website_endpoint
  description = "S3 static website endpoint name"
}

#######################################################
# CloudFront URL
#######################################################
output "cloudfront_url" {
  value       = module.cloudfront.cloudfront_domain
  description = "CloudFront distribution domain name"
}

#######################################################
# Visitor API URL
#######################################################
output "visitor_api_url" {
  value       = module.visitor_counter.api_endpoint
  description = "Visitor counter API Gateway URL"
}
