variable "name_prefix" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
  default = null
}

variable "iam_instance_profile" {
  type = string
  default = null
}

variable "associate_public_ip" {
  type = bool
  default = false
}

variable "security_group_ids" {
  type = list(string)
  default = []
}

variable "user_data" {
  type = string
  default = null
}

variable "tags" {
  type = map(string)
  default = {}
}