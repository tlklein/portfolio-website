variable "bucket_name" {
  description = "tlklein-porfolio-v2-terraform"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "prod"
}
