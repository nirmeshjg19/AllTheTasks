terraform {
  backend "s3" {
    
    bucket     = "practise-terraform"
    key        = "stage04mongo/terraform.tfstate"
    
  }
}