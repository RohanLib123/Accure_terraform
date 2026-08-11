resource "aws_vpc" "test-vpc" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true


  tags = {
    Name = "testing-vpc"
  }
}