#######################################################
# S3 Bucket name 
#######################################################
output "bucket_name" {
  description = "The name of the S3 bucket hosting the site"
  value       = aws_s3_bucket.site.bucket
}

#######################################################
# S3 Bucket ARN
#######################################################
output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.site.arn
}

#######################################################
# S3 Regional Domain Name
#######################################################
output "bucket_regional_domain_name" {
  description = "The regional domain name of the S3 bucket"
  value       = aws_s3_bucket.site.bucket_regional_domain_name
}

#######################################################
# Bucket Website Static Endpoint
#######################################################
output "bucket_website_endpoint" {
  value       = try(aws_s3_bucket_website_configuration.site.website_endpoint, null)
  description = "The static website endpoint (if configured)"
}
