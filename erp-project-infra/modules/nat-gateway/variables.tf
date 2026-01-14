variable "public_subnet_id" {
  description = "Public subnet where NAT Gateway will be created"
  type        = string
}

variable "nat_gateway_name" {
  description = "Name of the NAT Gateway"
  type        = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
