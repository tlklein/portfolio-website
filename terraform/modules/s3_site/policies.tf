#######################################################
# AWS Account Info Fetch
#######################################################
data "aws_caller_identity" "current" {}

#######################################################
# S3 website configuration
#######################################################
resource "aws_s3_bucket_website_configuration" "site" {
  bucket = aws_s3_bucket.site.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }
}


#######################################################
# OAC (Origin Access Control)
#######################################################
resource "aws_cloudfront_origin_access_control" "resume_oac" {
  name                              = "${var.project_prefix}-${var.environment}-OAC"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

#######################################################
# Bucket policy to only allow CloudFront (OAC) access
#######################################################
resource "aws_s3_bucket_policy" "cloudfront_access" {
  bucket = aws_s3_bucket.site.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "AllowCloudFrontOAC",
        Effect    = "Allow",
        Principal = { Service = "cloudfront.amazonaws.com" },
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.site.arn}/*",
        Condition = var.cloudfront_arn != "" ? {
          StringEquals = { "AWS:SourceArn" = var.cloudfront_arn }
        } : null
      }
    ]
  })
}

#######################################################
# Uploads all files from /public folder
#######################################################
resource "aws_s3_object" "static_files" {
  for_each = fileset("${path.module}/../public", "**")
  bucket   = aws_s3_bucket.site.id
  key      = each.value
  source   = "${path.module}/../public/${each.value}"
  etag     = filemd5("${path.module}/../public/${each.value}")
  content_type = lookup(
    var.mime_types,
    lower(element(split(".", each.value), length(split(".", each.value)) - 1)),
    "binary/octet-stream"
  )
  depends_on = [aws_s3_bucket_policy.cloudfront_access]
}