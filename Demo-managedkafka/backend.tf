terraform {
  backend "s3" {
    
    bucket     = "practise-terraform"
    key        = "stage05kafka/terraform.tfstate"
    
  }
}