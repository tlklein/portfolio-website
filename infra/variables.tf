variable "mime_types" {
  description = "Map of file extensions to MIME types"
  type = map(string)
  default = {
    ".html" = "text/html"
    ".css"  = "text/css"
    ".js"   = "application/javascript"
    ".png"  = "image/png"
    ".jpg"  = "image/jpeg"
    ".jpeg" = "image/jpeg"
    ".svg"  = "image/svg+xml"
    ".woff" = "font/woff"
    ".woff2" = "font/woff2"
  }
}

variable "cloudfront_distribution_comment" {
  description = "Comment for the CloudFront distribution"
  type        = string
  default     = "Cloud Resume Site Distribution"
}