resource "aws_internet_gateway" "demo-igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "Demo_IGW_01"
  }
}