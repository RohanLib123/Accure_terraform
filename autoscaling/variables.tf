variable "aws_region" {
  type = string
  default = "us-east-1"
}

variable "name_prefix" {
  type = string
  default = "prod-asg"
}

variable "vpc_subnet_ids" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
  default = []
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
  default = "t3.micro"
}

variable "key_name" {
  type = string
  default = null
}

variable "iam_instance_profile" {
  type = string
  default = null
}

variable "asg_min" {
  type = number
  default = 1
}

variable "asg_max" {
  type = number
  default = 3
}

variable "asg_desired" {
  type = number
  default = 1
}

variable "tags" {
  type = map(string)
  default = {
    "Environment" = "prod"
  }
}