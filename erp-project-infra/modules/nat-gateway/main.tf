############################
# Elastic IP for NAT
############################
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = merge(
    {
      Name = "${var.nat_gateway_name}-eip"
    },
    var.tags
  )
}

############################
# NAT Gateway
############################
resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.public_subnet_id

  tags = merge(
    {
      Name = var.nat_gateway_name
    },
    var.tags
  )

  depends_on = [aws_eip.nat]
}
