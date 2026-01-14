variable "name" {
  type        = string
  description = "Name of the target group"
}

variable "port" {
  type        = number
  default     = 80
  description = "Port on which target group receives traffic"
}

variable "protocol" {
  type        = string
  default     = "HTTP"
  description = "Protocol for target group"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where target group is created"
}

variable "health_check_protocol" {
  type        = string
  default     = "HTTP"
}

variable "health_check_path" {
  type        = string
  default     = "/health"
}

variable "health_check_interval" {
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  type        = number
  default     = 5
}

variable "health_check_healthy_threshold" {
  type        = number
  default     = 5
}

variable "health_check_unhealthy_threshold" {
  type        = number
  default     = 2
}

variable "tags" {
  type    = map(string)
  default = {}
}
