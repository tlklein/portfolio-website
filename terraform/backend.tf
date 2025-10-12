terraform {
  backend "s3" {
    bucket       = "tlklein-portfolio-tf-state"
    key          = "state/terraform.tfstate"
    region       = "us-east-2"
    encrypt      = true
    use_lockfile = true
    profile      = "tlklein-test"
  }
}