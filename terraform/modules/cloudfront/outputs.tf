#######################################################
# CloudFront Domain Name String
#######################################################
output "cloudfront_domain" {
  description = "The domain name of the CloudFront distribution"
  value       = aws_cloudfront_distribution.cdn.domain_name
}

#######################################################
# CloudFront Distribution ID
#######################################################
output "distribution_id" {
  description = "The ID of the CloudFront distribution"
  value       = aws_cloudfront_distribution.cdn.id
}

#######################################################
# CloudFront Distribution ARN
#######################################################
output "distribution_arn" {
  description = "ARN of the CloudFront distribution"
  value       = aws_cloudfront_distribution.cdn.arn
}

#######################################################
# CloudFront Domain Name
#######################################################
output "domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = aws_cloudfront_distribution.cdn.domain_name
}