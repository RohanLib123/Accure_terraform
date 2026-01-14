variable "cloudtrail_name" {
  type        = string
  default     = "all-regions-trail"
  description = "CloudTrail trail name"
}

variable "cloudtrail_s3_bucket" {
  type        = string
  description = "S3 bucket for CloudTrail logs"
}

variable "cloudwatch_log_group_arn" {
  type        = string
  default     = ""
  description = "CloudWatch log group ARN for CloudTrail"
}

variable "cloudwatch_role_arn" {
  type        = string
  default     = ""
  description = "IAM role ARN for CloudTrail CloudWatch integration"
}

variable "config_role_arn" {
  type        = string
  description = "IAM role ARN for AWS Config"
}

variable "config_s3_bucket" {
  type        = string
  description = "S3 bucket for AWS Config logs"
}

variable "tags" {
  type    = map(string)
  default = {}
}
