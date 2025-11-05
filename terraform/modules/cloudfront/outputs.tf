#######################################################
# CloudFront Zone ID
#######################################################
output "cloudfront_zone_id" {
  description = "The hosted zone ID for the CloudFront distribution"
  value       = aws_cloudfront_distribution.cdn.hosted_zone_id
}

#######################################################
# CloudFront Domain Name
#######################################################
output "cloudfront_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = aws_cloudfront_distribution.cdn.domain_name
}

#######################################################
# CloudFront OAC ID
#######################################################
output "oac_id" {
  description = "ID of the CloudFront Origin Access Control in use"
  value       = local.oac_id
}

#######################################################
# CloudFront Distribution ARN
#######################################################
output "distribution_arn" {
  value = aws_cloudfront_distribution.cdn.arn
}
