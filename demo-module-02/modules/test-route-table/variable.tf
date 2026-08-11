variable "vpc_id" {
  type        = string
  description = "VPC id comming from test-vpc module"

}

variable "vpc_cidr_block" {
  type        = string
  description = "VPC cidr block value"

}

variable "subnet_id" {
  type        = string
  description = "Subnet ID value comming from test-subnet module"

}

#variable "igw_id" {
 # type        = string
#  description = "Internet gatewy id comming from test-internet-gateway module"
#}