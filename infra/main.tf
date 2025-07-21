# Require specific version of terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92"
    }
  }
    required_version = ">= 1.2"

    backend "s3" {
    bucket = var.bucket_name
    key    = "infra/terraform.tfstate"
    region = "us-east-2"
  }
}

# Set provider to AWS, assume IAM role
provider "aws" {
    region = "us-east-2"
    assume_role_with_web_identity {
    role_arn                = "arn:aws:iam::230914977290:role/TerraformExecutionRole"
    session_name            = "terraform-execution"
    web_identity_token_file = "/Users/tf_user/secrets/web-identity-token"
  }
}
