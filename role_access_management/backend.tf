terraform {
  backend "s3" {
    bucket = "terrafrom-state-store-01-732343865328-ap-south-1-an"
    key = "network/terraform.tfstate"
    region = "ap-south-1"
    
  }
}