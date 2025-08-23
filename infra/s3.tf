
# Allow versioning on the the bucket for source control
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.resume_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable encryption on bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.resume_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block public access to bucket
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.resume_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# S3 website configuration (not required if you're serving via CloudFront root object)
resource "aws_s3_bucket_website_configuration" "static_site" {
  bucket = aws_s3_bucket.resume_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }
}

# Use OAC (Origin Access Control)
resource "aws_cloudfront_origin_access_control" "resume_oac" {
  name                              = "TlkleinPortfolio-OAC"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# Create a CDN
resource "aws_cloudfront_distribution" "cdn" {
  origin {
    domain_name = aws_s3_bucket.resume_bucket.bucket_regional_domain_name
    origin_id   = var.s3_origin_id

    origin_access_control_id = aws_cloudfront_origin_access_control.resume_oac.id
  }

  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.s3_origin_id

    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  depends_on = [
    aws_s3_bucket.resume_bucket,
    aws_s3_bucket_policy.cloudfront_access
  ]

  custom_error_response {
    error_code            = 404
    response_code         = 200
    response_page_path    = "/404.html"
    error_caching_min_ttl = 0
  }

  custom_error_response {
    error_code            = 403
    response_code         = 200
    response_page_path    = "/404.html"
    error_caching_min_ttl = 0
  }
  
  tags = {
    Name = "Tlklein Portfolio Cloudfront"
    Environment = "prod"
  }
}

# Bucket policy to only allow CloudFront (OAC) access
resource "aws_s3_bucket_policy" "cloudfront_access" {
  bucket = aws_s3_bucket.resume_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "AllowCloudFrontOAC",
        Effect    = "Allow",
        Principal = {
          Service = "cloudfront.amazonaws.com"
        },
        Action = "s3:GetObject",
        Resource = "${aws_s3_bucket.resume_bucket.arn}/*",
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.cdn.arn
          }
        }
      }
    ]
  })
}

# Uploads all files from /public folder
resource "aws_s3_object" "static_files" {
  for_each = fileset("${path.module}/../public", "**")

  bucket       = aws_s3_bucket.resume_bucket.id
  key          = each.value
  source       = "${path.module}/../public/${each.value}"
  etag         = filemd5("${path.module}/../public/${each.value}")
  content_type = lookup(
    var.mime_types,
    lower(element(split(".", each.value), length(split(".", each.value)) - 1)),
    "binary/octet-stream"
  )

  depends_on = [aws_s3_bucket_policy.cloudfront_access]
}