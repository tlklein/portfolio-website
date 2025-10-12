#######################################################
# Provider for Root Account
#######################################################
provider "aws" {
  region  = var.region
  profile = var.root_profile
}

#######################################################
# Provider for Test Account
#######################################################
provider "aws" {
  alias   = "test"
  region  = "us-east-2"
  profile = "tlklein-test"
}