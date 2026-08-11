resource "aws_route_table" "test-route-table" {
  vpc_id = var.vpc_id


 # route = {
 #   cidr_block = var.vpc_cidr_block
 #   gateway_id = var.igw_id
#
#  }

}

resource "aws_route_table_association" "route-table-association" {
  subnet_id      = var.subnet_id
  route_table_id = aws_route_table.test-route-table.id

}