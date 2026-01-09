terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

# ---------------------------
# VARIABLES
# ---------------------------
variable "project" {
  default = "erp-prod"
}

variable "db_password" {
  sensitive = true
}

variable "acm_cert_arn" {
  description = "ACM certificate ARN for HTTPS"
}

# ---------------------------
# VPC
# ---------------------------
resource "aws_vpc" "this" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "${var.project}-vpc" }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id
}

resource "aws_subnet" "public" {
  count                   = 2
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet("10.0.0.0/16", 8, count.index)
  availability_zone       = element(["ap-south-1a", "ap-south-1b"], count.index)
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private" {
  count             = 2
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet("10.0.0.0/16", 8, count.index + 10)
  availability_zone = element(["ap-south-1a", "ap-south-1b"], count.index)
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
}

resource "aws_route" "internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public" {
  count          = 2
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# ---------------------------
# SECURITY GROUPS
# ---------------------------
resource "aws_security_group" "alb_sg" {
  vpc_id = aws_vpc.this.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "app_sg" {
  vpc_id = aws_vpc.this.id

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "db_sg" {
  vpc_id = aws_vpc.this.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }
}

# ---------------------------
# S3 (ERP MEDIA)
# ---------------------------
resource "aws_s3_bucket" "media" {
  bucket = "${var.project}-media"
}

resource "aws_s3_bucket_public_access_block" "media" {
  bucket                  = aws_s3_bucket.media.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# ---------------------------
# IAM ROLE FOR EC2
# ---------------------------
resource "aws_iam_role" "ec2_role" {
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "s3" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_instance_profile" "this" {
  role = aws_iam_role.ec2_role.name
}

# ---------------------------
# LAUNCH TEMPLATE
# ---------------------------
resource "aws_launch_template" "erp" {
  name_prefix   = "erp-"
  image_id      = "ami-0f58b397bc5c1f2e8" # Amazon Linux 2023 (Mumbai)
  instance_type = "t3.medium"

  iam_instance_profile {
    name = aws_iam_instance_profile.this.name
  }

  network_interfaces {
    security_groups = [aws_security_group.app_sg.id]
  }

  user_data = base64encode(<<EOF
#!/bin/bash
dnf update -y
dnf install -y java-17 nginx
systemctl enable nginx
systemctl start nginx
EOF
  )
}

# ---------------------------
# AUTO SCALING GROUP
# ---------------------------
resource "aws_autoscaling_group" "erp" {
  desired_capacity    = 2
  max_size            = 4
  min_size            = 1
  vpc_zone_identifier = aws_subnet.private[*].id

  launch_template {
    id      = aws_launch_template.erp.id
    version = "$Latest"
  }
}

# ---------------------------
# ALB
# ---------------------------
resource "aws_lb" "this" {
  name               = "${var.project}-alb"
  load_balancer_type = "application"
  subnets            = aws_subnet.public[*].id
  security_groups    = [aws_security_group.alb_sg.id]
}

resource "aws_lb_target_group" "tg" {
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.this.id
}

resource "aws_autoscaling_attachment" "asg" {
  autoscaling_group_name = aws_autoscaling_group.erp.name
  lb_target_group_arn   = aws_lb_target_group.tg.arn
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.this.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn  = var.acm_cert_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

# ---------------------------
# RDS
# ---------------------------
resource "aws_db_subnet_group" "this" {
  subnet_ids = aws_subnet.private[*].id
}

resource "aws_db_instance" "erp" {
  engine               = "mysql"
  instance_class       = "db.t3.medium"
  allocated_storage    = 100
  db_name              = "erpdb"
  username             = "erpuser"
  password             = var.db_password
  multi_az             = true
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  db_subnet_group_name = aws_db_subnet_group.this.name
}
