resource "aws_cloudfront_distribution" "resume_distribution" {
  origin {
    domain_name = aws_s3_bucket.resume_site.bucket_regional_domain_name
    origin_id   = "TlkleinPortfolio-Origin"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.resume_oai.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "TlkleinPortfolio-Origin"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
  }

  price_class = "PriceClass_100"

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate_validation.resume_cert_validation.certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Name = "Tlklein Portfolio Cloudfront"
    Environment = "prod"
  }
}
