terraform {
  required_providers {
    aws = {
        source = "aws"
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