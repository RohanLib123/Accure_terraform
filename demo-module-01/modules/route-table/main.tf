resource "aws_route_table" "demo-route-table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id
  }
}

resource "aws_route_table_association" "demo-route-table-association" {
    subnet_id = var.subnet_id
    route_table_id = aws_route_table.demo-route-table.id
} 