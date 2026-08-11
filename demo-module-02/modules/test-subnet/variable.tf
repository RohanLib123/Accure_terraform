variable "vpc_id" {
  type        = string
  description = "Value is provided from test-vpc module"
}

variable "subnet_cidr_block" {
  type        = string
  description = "cidr block for subnet"
}

variable "availability_zone" {
  type        = string
  description = "Availabilty Zone for Subnet"
}

