variable "name" {
  type = string
}

variable "launch_template_id" {
  type = string
}

variable "launch_template_version" {
  type = string
  default = "$Latest"
}

variable "subnet_ids" {
  type = list(string)
}

variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "desired_capacity" {
  type = number
}

variable "health_check_type" {
  type = string
  default = "EC2"
}

variable "health_check_grace_period" {
  type = number
  default = 300
}

variable "tags_map" {
  type = map(string)
  default = {}
}