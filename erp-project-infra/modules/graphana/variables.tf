variable "name" {
  type        = string
  description = "Grafana workspace name"
}

variable "authentication_providers" {
  type        = list(string)
  default     = ["AWS_SSO"]
  description = "Authentication providers for Grafana"
}

variable "iam_role_arn" {
  type        = string
  description = "IAM Role for Grafana to access AWS resources (CloudWatch)"
}

variable "aws_region" {
  type        = string
  default     = "us-east-1"
}

variable "tags" {
  type    = map(string)
  default = {}
}
