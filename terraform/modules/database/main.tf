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

###########################################################
# Seed DynamoDB Table with Sample Visitors
###########################################################
resource "aws_dynamodb_table_item" "visitor" {
  for_each = {
      visitor1 = {
        ip_address  = "192.168.1.1"
        first_visit = 1697808000
        last_visit  = 1697894400
        visit_count = 3
      }
      visitor2 = {
        ip_address  = "192.168.1.2"
        first_visit = 1697809000
        last_visit  = 1697894500
        visit_count = 1
      }
  }

  table_name = aws_dynamodb_table.visitor.name
  hash_key   = aws_dynamodb_table.visitor.hash_key

  item = jsonencode({
    "ip_address" = { S = each.value.ip_address }
    first_visit = { N = tostring(each.value.first_visit) }
    last_visit  = { N = tostring(each.value.last_visit) }
    visit_count = { N = tostring(each.value.visit_count) }
  })
}