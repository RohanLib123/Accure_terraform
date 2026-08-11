output "display_vpc_id" {
  value = module.test-vpc.vpc_id
}

output "display_subnet_id" {
  value = module.test-subnet.subnet_id
}

output "display_route_table_id" {
  value = module.test-route-table.route_table_id
}

output "display_internet_gateway_id" {
    value = module.test-internet-gateway.igw_id
}