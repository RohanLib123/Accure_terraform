variable "aws_region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "db_subnet_ids" {
  type = list(string)
}

variable "db_admin_cidrs" {
  type = list(string)
}

variable "db_name" {
  type = string
  default = "appdb"
}

variable "db_username" {
  type = string
  default = "admin"
}

variable "ec2_ami" {
  type = string
}

variable "ec2_subnet_id" {
  type = string
}

variable "ec2_key_name" {
  type = string
}

variable "tags" {
  type = map(string)
  default = {}
}


