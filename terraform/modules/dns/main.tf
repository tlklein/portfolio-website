#######################################################
# Import Route53 Zone Data Source 
#######################################################
data "aws_route53_zone" "existing" {
  name         = var.domain_name
  zone_id = var.cloudfront_zone_id
  private_zone = false
}