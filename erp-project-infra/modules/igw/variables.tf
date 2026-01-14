variable "vpc_id" {
  description = "VPC ID to attach the Internet Gateway"
  type        = string
}

variable "igw_name" {
  description = "Name of the Internet Gateway"
  type        = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
