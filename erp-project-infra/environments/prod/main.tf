provider "aws" {
  region = "ap-south-1"
}

provider "aws" {
  alias  = "use1"
  region = "us-east-1"
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


module "erp_prod_igw" {
  source = "../modules/igw"

  vpc_id   = module.erp_prod_vpc.vpc_id
  igw_name = "erp-prod-igw"

  tags = {
    Environment = "production"
    Project     = "ERP"
  }
}


module "erp_nat_gateway" {
  source = "../modules/nat-gateway"

  public_subnet_id = module.erp_subnets.public_subnet_ids[0]
  nat_gateway_name = "erp-prod-nat"

  tags = {
    Environment = "production"
    Project     = "ERP"
  }
}


module "erp_route_tables" {
  source = "../modules/route-table"

  vpc_id           = module.erp_prod_vpc.vpc_id
  igw_id           = module.erp_prod_igw.igw_id
  nat_gateway_id   = module.erp_nat_gateway.nat_gateway_id

  public_subnet_ids  = module.erp_subnets.public_subnet_ids
  private_subnet_ids = module.erp_subnets.private_subnet_ids

  public_rt_name  = "public-rt"
  private_rt_name = "private-rt"

  tags = {
    Environment = "production"
    Project     = "ERP"
  }
}

module "erp_frontend_s3" {
  source = "../modules/s3"

  bucket_name = "erp-prod-frontend"

  tags = {
    Environment = "production"
    Project     = "ERP"
    Component   = "frontend"
  }
}


provider "aws" {
  region = "ap-south-1"
}

provider "aws" {
  alias  = "use1"
  region = "us-east-1"
}

module "erp_cloudfront_waf" {
  source = "../modules/cloudfront-waf"

  providers = {
    aws.use1 = aws.use1
  }

  bucket_domain_name   = module.erp_frontend_s3.website_endpoint
  acm_certificate_arn = "arn:aws:acm:us-east-1:XXXX:certificate/XXXX"

  cloudfront_name = "erp-prod-cloudfront"
  waf_name        = "erp-prod-waf"

  tags = {
    Environment = "production"
    Project     = "ERP"
  }
}

