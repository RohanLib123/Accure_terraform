variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
  default = "t3.micro"
}

variable "subnet_id" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "key_name" {
  type = string
  default = null
}

variable "iam_instance_profile_arn" {
  type = string
  default = null
}

variable "user_data" {
  type = string
  default = ""
}

variable "tags" {
  type = map(string)
  default = []
}