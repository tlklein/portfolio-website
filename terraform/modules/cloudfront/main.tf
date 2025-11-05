#######################################################
# Locals
#######################################################
locals {
  common_tags = merge(
    {
      Project     = var.project_prefix
      Environment = var.environment
      Owner       = "Trinity Klein"
      Purpose     = "Cloud Resume Challenge"
    },
    var.tags
  )
  s3_origin_id = "${var.project_prefix}-origin"
  oac_id = var.existing_oac_id != "" ? var.existing_oac_id : aws_cloudfront_origin_access_control.this.id
}

#######################################################
# Provider for Root Account
#######################################################
provider "aws" {
  profile = var.root_profile
}

#######################################################
# Data: Existing Origin Access Control
#
# data "aws_cloudfront_origin_access_control" "existing" {
#  id = var.existing_oac_id
#  # name = var.existing_oac_name
# }
#######################################################

###########################################################
# Create CloudFront Origin Access Control (OAC)
###########################################################
resource "aws_cloudfront_origin_access_control" "this" {
  name                              = "${var.project_prefix}-${var.environment}-cloudfront"
  description                       = "CloudFront for ${var.project_prefix}-${var.environment}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"

  lifecycle {
    prevent_destroy = true
  }
}


#######################################################
# CloudFront Cache & Origin Request Policies (CORS)
#######################################################
resource "aws_cloudfront_cache_policy" "cors_cache_policy" {
  name        = "${var.project_prefix}-cors-cache-policy"
  comment     = "Cache policy allowing CORS headers for ${var.project_prefix}"
  default_ttl = 86400
  min_ttl     = 0
  max_ttl     = 31536000

  parameters_in_cache_key_and_forwarded_to_origin {
    enable_accept_encoding_brotli = true
    enable_accept_encoding_gzip   = true
    headers_config {
      header_behavior = "whitelist"
      headers {
        items = ["Origin"]
      }
    }
    cookies_config {
      cookie_behavior = "none"
    }
    query_strings_config {
      query_string_behavior = "none"
    }
  }
}

resource "aws_cloudfront_origin_request_policy" "cors_request_policy" {
  name    = "${var.project_prefix}-cors-request-policy"
  comment = "Forward Origin header for CORS fonts and static assets"

  headers_config {
    header_behavior = "whitelist"
    headers {
      items = ["Origin"]
    }
  }

  cookies_config {
    cookie_behavior = "none"
  }

  query_strings_config {
    query_string_behavior = "none"
  }
}

#######################################################
# CloudFront Distribution
#######################################################
resource "aws_cloudfront_distribution" "cdn" {
  enabled             = true
  is_ipv6_enabled     = true
  http_version        = "http3"
  default_root_object = "index.html"
  depends_on = [aws_cloudfront_origin_access_control.this]

  origin {
    domain_name              = "${var.origin_bucket_domain_name}"
    origin_id                = "${var.origin_bucket}-origin"
    origin_access_control_id = aws_cloudfront_origin_access_control.this.id
  }

  default_cache_behavior {
    target_origin_id       = "${var.origin_bucket}-origin"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id          = aws_cloudfront_cache_policy.cors_cache_policy.id
    origin_request_policy_id = aws_cloudfront_origin_request_policy.cors_request_policy.id
    compress = true
  }

  price_class = "PriceClass_100"

   aliases = ["www.trinityklein.dev", "trinityklein.dev"]

  viewer_certificate {
    acm_certificate_arn      = var.acm_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = local.common_tags
}


#######################################################
# Route53 Alias Records
#######################################################
 resource "aws_route53_record" "cdn" {
  for_each = toset([var.domain_name, "www.${var.domain_name}"])

  zone_id = var.cloudfront_zone_id
  name    = each.value
  type    = "A"
  depends_on = [aws_cloudfront_distribution.cdn]

  alias {
    name                   = aws_cloudfront_distribution.cdn.domain_name
    zone_id                = aws_cloudfront_distribution.cdn.hosted_zone_id
    evaluate_target_health = true
  }
}