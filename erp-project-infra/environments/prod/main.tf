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

module "alb_sg" {
  source        = "./terraform-modules/security_group"
  sg_name       = "alb-sg"
  sg_description = "ALB Security Group"
  vpc_id        = aws_vpc.main.id
  ingress_rules = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow HTTPS from anywhere"
    }
  ]
  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound"
    }
  ]
}

module "app_sg" {
  source        = "./terraform-modules/security_group"
  sg_name       = "app-ec2-sg"
  sg_description = "App EC2 Security Group"
  vpc_id        = aws_vpc.main.id
  ingress_rules = [
    {
      from_port      = 80
      to_port        = 80
      protocol       = "tcp"
      security_groups = [module.alb_sg.sg_id]
      description    = "Allow HTTP from ALB"
    },
    {
      from_port      = 443
      to_port        = 443
      protocol       = "tcp"
      security_groups = [module.alb_sg.sg_id]
      description    = "Allow HTTPS from ALB"
    }
  ]
  egress_rules = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = [] # optional, depends on DB subnet, can also reference SG
      description = "Allow MySQL outbound"
    },
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = []
      description = "Allow PostgreSQL outbound"
    }
  ]
}

module "db_sg" {
  source        = "./terraform-modules/security_group"
  sg_name       = "db-sg"
  sg_description = "Database Security Group"
  vpc_id        = aws_vpc.main.id
  ingress_rules = [
    {
      from_port      = 3306
      to_port        = 3306
      protocol       = "tcp"
      security_groups = [module.app_sg.sg_id]
      description    = "Allow MySQL from App EC2 SG"
    },
    {
      from_port      = 5432
      to_port        = 5432
      protocol       = "tcp"
      security_groups = [module.app_sg.sg_id]
      description    = "Allow PostgreSQL from App EC2 SG"
    }
  ]
  egress_rules = [] # no public access
}

module "public_alb" {
  source             = "./terraform-modules/alb"
  name               = "erp-public-alb"
  subnets            = [aws_subnet.public1.id, aws_subnet.public2.id]
  security_groups    = [module.alb_sg.sg_id]
  vpc_id             = aws_vpc.main.id
  acm_certificate_arn = aws_acm_certificate.erp_cert.arn
  tags = {
    Environment = "prod"
    Project     = "ERP"
  }
}

module "app_tg" {
  source  = "./terraform-modules/target_group"
  name    = "erp-app-tg"
  vpc_id  = aws_vpc.main.id
  port    = 80
  protocol = "HTTP"
  health_check_path = "/health"
  tags = {
    Environment = "prod"
    Project     = "ERP"
  }
}

module "backend_ec2" {
  source  = "./terraform-modules/ec2_instance"
  ami_id  = "ami-0abcd1234efgh5678" # Replace with your AMI
  instance_type = "t3.medium"
  subnet_id     = aws_subnet.private_app1.id
  security_group_ids = [module.app_sg.sg_id]
  key_name      = "my-keypair"
  iam_role_name = "backend-ec2-role"
  iam_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  ]
  tags = {
    Environment = "prod"
    Project     = "ERP"
  }
}

module "erp_rds" {
  source               = "./terraform-modules/rds"
  db_name              = "erpdb"
  db_subnet_group_name = "erp-db-subnet-group"
  subnet_ids           = [aws_subnet.private_app1.id, aws_subnet.private_app2.id]
  security_group_ids   = [module.db_sg.sg_id]
  username             = "admin"
  password             = "StrongPassword123!"
  instance_class       = "db.t3.medium"
  engine               = "mysql"
  engine_version       = "8.0"
  multi_az             = true
  enable_read_replica  = true
  tags = {
    Environment = "prod"
    Project     = "ERP"
  }
}

module "cloudwatch_monitoring" {
  source = "./terraform-modules/cloudwatch"

  ec2_instance_ids = {
    app1 = module.backend_ec2.instance_id
  }

  alb_arns = {
    public_alb = module.public_alb.alb_arn
  }

  alarm_actions = [
    aws_sns_topic.alerts.arn
  ]
  
  ec2_cpu_threshold          = 80
  ec2_period                 = 300
  ec2_eval_periods           = 2
  alb_period                 = 60
  alb_eval_periods           = 2
  alb_unhealthy_threshold    = 0
}
