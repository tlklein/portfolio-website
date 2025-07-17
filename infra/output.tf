output "bucket_name" {
  value = aws_s3_bucket.resume_bucket.bucket
}

output "static_website_url" {
  value = aws_s3_bucket_website_configuration.static_site.website_endpoint
}
