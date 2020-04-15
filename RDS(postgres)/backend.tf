terraform {
  backend "s3" {
    
    bucket     = "practise-terraform"
    key        = "stage03rds/terraform.tfstate"
    
  }
}