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

module "erp_subnets" {
  source = "../modules/subnets"

  vpc_id = module.erp_prod_vpc.vpc_id

  public_subnets = [
    {
      name = "public-subnet-1"
      az   = "ap-south-1a"
      cidr = "10.0.1.0/24"
    },
    {
      name = "public-subnet-2"
      az   = "ap-south-1b"
      cidr = "10.0.2.0/24"
    }
  ]

  private_subnets = [
    {
      name = "private-app-1"
      az   = "ap-south-1a"
      cidr = "10.0.11.0/24"
    },
    {
      name = "private-app-2"
      az   = "ap-south-1b"
      cidr = "10.0.12.0/24"
    }
  ]

  tags = {
    Environment = "production"
    Project     = "ERP"
  }
}
