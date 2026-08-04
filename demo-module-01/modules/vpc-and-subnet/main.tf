resource "aws_vpc" "demo-vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "Demo_VPC_01"
  }
}

resource "aws_subnet" "demo-subnet" {
  vpc_id = aws_vpc.demo-vpc.id
  cidr_block = var.subnet_cidr
  availability_zone = var.availability_zone 
  map_public_ip_on_launch = true
    
  tags = {
    Name = "Demo_Subnet_01"
  }
}