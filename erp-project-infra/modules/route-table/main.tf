############################
# Public Route Table
############################
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = merge(
    {
      Name = var.public_rt_name
      Tier = "public"
    },
    var.tags
  )
}

############################
# Associate Public Subnets
############################
resource "aws_route_table_association" "public" {
  for_each = toset(var.public_subnet_ids)

  subnet_id      = each.value
  route_table_id = aws_route_table.public.id
}

############################
# Private Route Table
############################
resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_id
  }

  tags = merge(
    {
      Name = var.private_rt_name
      Tier = "private"
    },
    var.tags
  )
}

############################
# Associate Private Subnets
############################
resource "aws_route_table_association" "private" {
  for_each = toset(var.private_subnet_ids)

  subnet_id      = each.value
  route_table_id = aws_route_table.private.id
}
