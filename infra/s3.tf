# Creating a random string 
resource "random_string" "random_s3" {
  length = 4
  special = false
  upper = false
} 

# Create an S3 Bucket
resource "aws_s3_bucket" "resume_bucket" {
  bucket = "TlkleinPortfolio-V${random_string.random_s3.result}"

  tags = {
    Name = "Tlklein Portfolio S3 Bucket"
    Environment = "prod"
  }
}

# Allow static website endpoint, set index.html and 404.html
resource "aws_s3_bucket_website_configuration" "static_site" {
  bucket = aws_s3_bucket.resume_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }
}

# Enable bucket versioning
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.resume_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Disable public access 
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.resume_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable SS3 Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.static_site.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Set AWS bucket policy to only allow cloudfront service principal
resource "aws_s3_bucket_policy" "public_policy" {
  bucket = aws_s3_bucket.resume.id

  policy = jsonencode({
    Version = "2012-10-17",
    "Statement": [
    {
        "Sid": "AllowCloudFrontServicePrincipal",
        "Effect": "Allow",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": "${aws_s3_bucket.resume.arn}/*"
    }]
  })
}


# Upload all files from ./public/ directory
resource "aws_s3_object" "static_files" {
  for_each = fileset("${path.module}/../public", "**")

  bucket       = aws_s3_bucket.static_site.id
  key          = each.value
  source       = "${path.module}/../public/${each.value}"
  content_type = lookup(var.mime_types, substr(each.value, length(each.value) - 4, 4), "binary/octet-stream")
  etag         = filemd5("${path.module}/../public/${each.value}")
}

output "website_url" {
  value = aws_s3_bucket.static_site.website_endpoint
}