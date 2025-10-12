#######################################################
# Route 53  Zone ID
#######################################################
output "zone_id" {
  description = "The ID of the Route53 hosted zone for the project"
  value       = data.aws_route53_zone.primary.zone_id
}

#######################################################
# Route 53 Zone Name
#######################################################
output "zone_name" {
  description = "The name of the Route53 hosted zone"
  value       = data.aws_route53_zone.primary.name
}

