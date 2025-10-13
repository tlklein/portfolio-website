terraform {
  backend "s3" {
    bucket       = "tlklein-portfolio-tf-state"
    key          = "state/terraform.tfstate"
    region       = "us-east-2"
    encrypt      = true
    dynamodb_table = "terraform-locks"
    profile      = "tlklein-test"
  }
}