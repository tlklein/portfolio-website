
output "bucket_name" {
  value = aws_s3_bucket.resume_bucket.bucket
  description = "The name of the S3 bucket hosting the resume site"
}

output "static_website_url" {
  value = aws_s3_bucket_website_configuration.static_site.website_endpoint
  description = "S3 static website endpoint name"
}

output "cloudfront_url" {
  value       = aws_cloudfront_distribution.resume_distribution.domain_name
  description = "CloudFront distribution domain name"
}

output "visitor_api_url" {
  value       = module.visitor_counter.api_endpoint
  description = "Visitor counter API Gateway URL"
}
