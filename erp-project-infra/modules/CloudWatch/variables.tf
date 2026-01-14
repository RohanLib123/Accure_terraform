variable "ec2_instance_ids" {
  type        = map(string)
  description = "Map of EC2 instance names to IDs for monitoring"
}

variable "alb_arns" {
  type        = map(string)
  description = "Map of ALB names to ARNs for monitoring unhealthy hosts"
}

variable "alarm_actions" {
  type        = list(string)
  default     = []
  description = "List of SNS topic ARNs or actions for alarms"
}

variable "ec2_cpu_threshold" {
  type        = number
  default     = 80
  description = "CPU utilization threshold %"
}

variable "ec2_period" {
  type        = number
  default     = 300
  description = "Period in seconds for EC2 metric"
}

variable "ec2_eval_periods" {
  type        = number
  default     = 2
  description = "Evaluation periods for EC2 CPU alarm"
}

variable "alb_period" {
  type        = number
  default     = 60
  description = "Period in seconds for ALB metric"
}

variable "alb_eval_periods" {
  type        = number
  default     = 2
  description = "Evaluation periods for ALB alarm"
}

variable "alb_unhealthy_threshold" {
  type        = number
  default     = 0
  description = "Threshold for unhealthy hosts (count)"
}
