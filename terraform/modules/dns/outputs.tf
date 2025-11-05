#######################################################
# Route53 Zone ID
#######################################################
output "zone_id" {
  description = "The Route53 Hosted Zone ID"
  value       = data.aws_route53_zone.existing.zone_id
}

#######################################################
# Route53 Zone Name 
#######################################################
output "zone_name" {
  description = "The Route53 Hosted Zone Name"
  value       = data.aws_route53_zone.existing.name
}
