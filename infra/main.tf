terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
  required_version = ">= 1.2"
  
  # State snapshot backup
  backend "s3" {
    bucket         = "tlklein-portfolio-tf-state" 
    key            = "state/terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
    use_lockfile   = true
    profile        = "tlklein-test"
  }
}

# Provider for Root Account
provider "aws" {
  region  = var.region
  profile = var.root_profile
}

# Provider for Test Account
provider "aws" {
  alias   = "test"
  region  = "us-east-2"
  profile = "tlklein-test"
}

variable "create_role" {
  type    = bool
  default = false
}

resource "aws_iam_role" "terraform_exec" {
  count = var.create_role ? 1 : 0
  name  = "TerraformExecutionRole"

  assume_role_policy = jsonencode({
  "Version" : "2012-10-17",
  "Statement" : [
    {
      "Sid"    : "AllowS3StaticSite",
      "Effect" : "Allow",
      "Action" : [
        "s3:PutObject",
        "s3:DeleteObject",
        "s3:GetObject",
        "s3:ListBucket",
        "s3:PutBucketWebsite",
        "s3:GetBucketWebsite",
        "s3:PutEncryptionConfiguration",
        "s3:GetEncryptionConfiguration",
        "s3:GetBucketVersioning",
        "s3:PutBucketVersioning",
        "s3:PutBucketPublicAccessBlock",
        "s3:GetBucketPublicAccessBlock"
      ],
      "Resource": [
        var.s3_arn,
        var.s3_arn_files
      ]
    },
    {
      "Sid"    : "AllowTerraformActions",
      "Effect" : "Allow",
      "Action" : [
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject",
        "s3:ListBucket"
      ],
      "Resource": [
        var.s3_state_arn,
        var.s3_state_files
      ]
    },
    {
      "Sid"    : "TerraformDynamoDBStateLocking",
      "Effect" : "Allow",
      "Action" : [
        "dynamodb:DescribeTable",
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:DeleteItem"
      ],
      "Resource": var.dynamodb_arn
    },
    {
      "Sid"      : "AllowAssumeTerraformExecutionRoleRoot",
      "Effect"   : "Allow",
      "Action"   : "sts:AssumeRole",
      "Resource" : var.root_role_arn
    },
    {
      "Sid"      : "AllowAssumeTerraformExecutionRoleTest",
      "Effect"   : "Allow",
      "Action"   : "sts:AssumeRole",
      "Resource" : var.test_role_arn
    }
  ]
})
}


# Creating a random string 
resource "random_string" "random_s3" {
  length = 4
  special = false
  upper = false
} 

# Create an S3 Bucket
resource "aws_s3_bucket" "resume_bucket" {
  provider = aws.test
  bucket = var.bucket_name
  force_destroy = true
  
  tags = {
    Name = "Tlklein Portfolio S3 Terraform Bucket"
    Environment = "prod"
  }
}