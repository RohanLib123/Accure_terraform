terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Create Custom VPC
resource "aws_vpc" "custom_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "custom-vpc"
  }
}

# Create subnet without IGW or RT
resource "aws_subnet" "subnet_no_igw" {
  vpc_id    = aws_vpc.custom_vpc.id
  cidr_block    = "10.0.1.0/24"
  availability_zone = "us-east-1f"

  tags = {
    Name = "test-private-subnet"
  }
}

# create Route table
resource "aws_route_table" "custom_rt" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "Custom-rt"
  }
}

# Assosiate subnet with route table
resource "aws_route_table_association" "subnet_associ" {
  subnet_id = aws_subnet.subnet_no_igw.id
  route_table_id = aws_route_table.custom_rt.id
}