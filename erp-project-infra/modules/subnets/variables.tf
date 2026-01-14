variable "vpc_id" {
  description = "VPC ID where subnets will be created"
  type        = string
}

variable "public_subnets" {
  description = "Public subnets configuration"
  type = list(object({
    name = string
    az   = string
    cidr = string
  }))
}

variable "private_subnets" {
  description = "Private subnets configuration"
  type = list(object({
    name = string
    az   = string
    cidr = string
  }))
}

variable "tags" {
  type    = map(string)
  default = {}
}
