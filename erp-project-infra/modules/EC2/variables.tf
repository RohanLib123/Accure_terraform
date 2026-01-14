variable "ami_id" {
  type        = string
  description = "AMI ID for EC2 instance"
}

variable "instance_type" {
  type        = string
  default     = "t3.medium"
  description = "EC2 instance type"
}

variable "subnet_id" {
  type        = string
  description = "Private subnet ID for EC2"
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security groups for EC2"
}

variable "key_name" {
  type        = string
  description = "EC2 key pair name"
}

variable "iam_role_name" {
  type        = string
  description = "IAM role name for EC2"
}

variable "iam_policy_arns" {
  type        = list(string)
  description = "List of IAM policy ARNs to attach (e.g., S3, CloudWatch)"
}

variable "tags" {
  type    = map(string)
  default = {}
}
