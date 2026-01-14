provider "aws" {
  region = "ap-south-1"
}

module "erp_prod_vpc" {
  source = "../modules/vpc"

  vpc_name  = "erp-prod-vpc"
  cidr_block = "10.0.0.0/16"

  tags = {
    Environment = "production"
    Project     = "ERP"
    Owner       = "CloudTeam"
  }
}
