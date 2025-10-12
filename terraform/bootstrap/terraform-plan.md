aws sso login --profile tlklein-test

terraform init or terraform init --reconfigure

terraform fmt -recursive
terraform validate

terraform plan -out=tfplan 
terraform plan -var-file="terraform.tfvars"

terraform apply tfplan