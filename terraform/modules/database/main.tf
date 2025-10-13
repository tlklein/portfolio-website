#######################################################
# Locals
#######################################################
locals {
  common_tags = {
    Project     = var.project_prefix
    Environment = var.environment
    Owner       = "Trinity Klein"
    Purpose     = "Cloud Resume Challenge"
  }
}

#######################################################
# DynamoDB Table 
#######################################################
resource "aws_dynamodb_table" "visitor" {
  name         = var.table_name
  billing_mode = var.billing_mode

  hash_key = "ip_address"

  attribute {
    name = "ip_address"
    type = "S"
  }

  attribute {
    name = "first_visit"
    type = "N"
  }

  attribute {
    name = "last_visit"
    type = "N"
  }

  attribute {
    name = "visit_count"
    type = "N"
  }

  point_in_time_recovery {
    enabled = true
  }

  ttl {
    attribute_name = "expiration_time"
    enabled        = false
  }

  server_side_encryption {
    enabled = true
  }

  tags = local.common_tags
}
