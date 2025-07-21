# Creating a random string ${random_string.random.result}
resource "random_string" "random_dynamodb" {
  length = 4
  special = false
  upper = false
} 

# Create dynamodb table
# FIXME: Double-check attributes to make sure they exist
resource "aws_dynamodb_table" "VisitorCount" {
  name           = "VisitorCounter-V${random_string.random_dynamodb.result}"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "visit_count"

  attribute {
    name = "visit_count"
    type = "N"
  }

  attribute {
    name = "first_visit"
    type = "S"
  }

  attribute {
    name = "last_visit"
    type = "S"
  }
  
  tags = {
    Name = "Visitor Counter DynamoDB Table For Lambda Function"
    Environment = "prod"
    }
  }
