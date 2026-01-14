variable "name" {
  type        = string
  description = "Name of the ALB"
}

variable "subnets" {
  type        = list(string)
  description = "List of public subnet IDs"
}

variable "security_groups" {
  type        = list(string)
  description = "Security Group IDs for ALB"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where ALB is deployed"
}

variable "acm_certificate_arn" {
  type        = string
  description = "ACM SSL certificate ARN for HTTPS listener"
}

variable "target_group_port" {
  type        = number
  default     = 80
  description = "Port for target group"
}

variable "target_group_protocol" {
  type        = string
  default     = "HTTP"
  description = "Protocol for target group"
}

variable "health_check_protocol" {
  type        = string
  default     = "HTTP"
}

variable "health_check_path" {
  type        = string
  default     = "/"
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

variable "enable_deletion_protection" {
  type        = bool
  default     = false
}

variable "idle_timeout" {
  type        = number
  default     = 60
}

variable "tags" {
  type    = map(string)
  default = {}
}
