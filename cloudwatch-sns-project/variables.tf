variable "instance_id" {
  type = string
}

variable "email" {
  type = string
}

variable "cpu_threshold" {
  type = number
  default = 80
}

variable "tags" {
  type = map(string)
  default = {}
}

