resource "aws_internet_gateway" "test-internet-gateway" {
  vpc_id = var.vpc_id

  tags = {
    Name = "Test Internet Gateway"
  }

}