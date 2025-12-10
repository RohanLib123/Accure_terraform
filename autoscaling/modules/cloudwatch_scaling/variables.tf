variable "asg_name" {
  type = string
}

variable "cpu_target_value" {
  type = number
  default = 60
}

variable "disable_scale_in" {
  type = bool
  default = false
}

variable "step_upper_threshold" {
  type = number
  default = 80
}

variable "step_lower_threshold" {
  type = number
  default = 30
}

variable "step_up_adjustment" {
  type = number
  default = 1
}

variable "step_down_adjustment" {
  type = number
  default = -1
}