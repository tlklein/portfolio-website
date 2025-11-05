#######################################################
# AWS Account Info Fetch
#######################################################
data "aws_caller_identity" "current" {}



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
# NOTE: May have to fix ARNs 
#######################################################
resource "aws_s3_bucket_policy" "cloudfront_access" {
  bucket = aws_s3_bucket.site.id
  depends_on = [aws_s3_bucket.site]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowCloudFrontOACAccess"
        Effect    = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = [
          "s3:GetObject",
          "s3:PutObject"
          ]
        Resource = "${aws_s3_bucket.site.arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = var.cloudfront_arn 
          }
        }
      },
      {
      "Sid": "AllowCORSUpdate",
      "Effect": "Allow",
      "Principal": {
        "AWS": var.test_sso_arn
      },
      "Action": [
        "s3:PutBucketCORS",
        "s3:GetBucketCORS"
      ],
      "Resource": "${aws_s3_bucket.site.arn}"
    }
    ]
  })
}

#######################################################
# S3 CORS Configuration
#######################################################
resource "aws_s3_bucket_cors_configuration" "origin" {
  bucket = aws_s3_bucket.site.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = [
      "https://www.trinityklein.dev",
      "https://trinityklein.dev"
    ]
    expose_headers = ["Access-Control-Allow-Origin"]
    max_age_seconds = 3000
  }
}

#######################################################
# Uploads all files from /public folder
#######################################################
resource "aws_s3_object" "static_files" {
  for_each = fileset("${path.module}/../../../public", "**")

  bucket = aws_s3_bucket.site.id
  key    = each.value
  source = "${path.module}/../../../public/${each.value}"
  etag   = filemd5("${path.module}/../../../public/${each.value}")

  content_type = lookup(
    var.mime_types,
    lower(element(split(".", each.value), length(split(".", each.value)) - 1)),
    "binary/octet-stream"
  )

  depends_on = [aws_s3_bucket.site]
}