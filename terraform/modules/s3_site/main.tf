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
# Create S3 Bucket
#######################################################
resource "aws_s3_bucket" "site" {
  bucket        = var.bucket_name
  force_destroy = false
  tags          = local.common_tags
}

#######################################################
# Enable Server-side Encryption
#######################################################
resource "aws_s3_bucket_server_side_encryption_configuration" "site" {
  bucket = aws_s3_bucket.site.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

#######################################################
# Enable Bucket Lifecycle Policy
#######################################################
resource "aws_s3_bucket_lifecycle_configuration" "site" {
  bucket = aws_s3_bucket.site.id

  rule {
    id     = "noncurrent-to-one-1a"
    status = "Enabled"
    filter {}

    noncurrent_version_transition {
      noncurrent_days = 30
      storage_class   = "ONEZONE_IA"
    }
  }

  rule {
    id     = "noncurrent-to-glacier"
    status = "Enabled"
    filter {}

    noncurrent_version_transition {
      noncurrent_days = 7
      storage_class   = "GLACIER"
    }
  }
}


#######################################################
# Enable versioning on bucket
#######################################################
resource "aws_s3_bucket_versioning" "site" {
  bucket = aws_s3_bucket.site.id
  versioning_configuration {
    status = "Enabled"
  }
}

#######################################################
# Block all public access
#######################################################
resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.site.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

