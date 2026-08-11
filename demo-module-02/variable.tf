variable "aws_provider_region" {
  type        = string
  description = "Region name for aws provide block"
}

variable "access_key" {
  type        = string
  description = "Access key of user"
}

variable "secret_access_key" {
  type        = string
  description = "Secret access key of user"
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for vpc"
}

variable "subnet_cidr_block" {
  type        = string
  description = "CIDR block for Subnet"
}

variable "availability_zone" {
  type        = string
  description = "Availability Zone value"
}