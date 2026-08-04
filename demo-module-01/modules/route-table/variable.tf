variable "vpc_id" {
  description = "The ID of the VPC where the route table will be created."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the route table will be associated."
  type        = string
}

variable "internet_gateway_id" {
  description = "The ID of the Internet Gateway to be used in the route table."
  type        = string
}