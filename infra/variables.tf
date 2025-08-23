
# Current Environment
variable "environment" {
  default     = "prod"
  description = "default enviornment name"
  type        = string
}

# Default AWS region
variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-2"
}

# Root Profile Name
variable "root_profile" {
  description = "AWS CLI profile for the root account"
  type        = string
  default     = "tlklein"
}

# Test Profile Name
variable "test_profile" {
  description = "AWS CLI profile for the test account"
  type        = string
  default     = "tlklein-test"
}

# Terraform role arn for root
variable "root_role_arn" {
  description = "ARN of the IAM role for root account"
  default     = "arn:aws:iam::230914977290:role/TerraformExecutionRole"
  type        = string
}

# Terraform role arn for test
variable "test_role_arn" {
  description = "ARN of the IAM role for root account"
  default     = "arn:aws:iam::070634855522:role/TerraformExecutionRole"
  type        = string
}

# Terraform test account sso arn
variable "test_sso_arn" {
  description = "ARN of the IAM role for root account"
  default     = "arn:aws:sts::070634855522:assumed-role/AWSReservedSSO_AdminLimitedAccess_23f24c5e34779300/tlklein-test"
  type        = string
}

# Dynamodb table arn for state lock table
variable "dynamodb_arn"{
  description = "ARN for dynamodb table for state locking"
  default     = "arn:aws:dynamodb:us-east-2:230914977290:table/TerraformLocks"
  type        = string
}

# S3 bucket table arn main
variable "s3_arn"{
  description = "ARN for main S3 bucket"
  default     = "arn:aws:s3:::tlklein-portfolio-v2"
  type        = string
}

# S3 bucket table arn to allow change files main
variable "s3_arn_files"{
  description = "ARN for main S3 bucket to allow change files"
  default     = "arn:aws:s3:::tlklein-portfolio-v2/*"
  type        = string
}

# S3 bucket table arn for state locking 
variable "s3_state_arn"{
  description = "ARN for S3 bucket for state locking"
  default     = "arn:aws:s3:::tlklein-portfolio-tf-state"
  type        = string
}

# S3 bucket table arn for state locking allow change files 
variable "s3_state_files"{
  description = "ARN for S3 bucket to allow change files in state lock"
  default     = "arn:aws:s3:::tlklein-portfolio-tf-state/*"
  type        = string
}
# S3 bucket name
variable "bucket_name" {
  description = "Name of the S3 bucket for the resume site"
  type        = string
  default     = "v3-tlklein-portfolio"
}
