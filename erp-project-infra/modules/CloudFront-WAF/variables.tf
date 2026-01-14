variable "bucket_domain_name" {
  description = "S3 static website or S3 origin domain"
  type        = string
}

variable "acm_certificate_arn" {
  description = "ACM certificate ARN (must be in us-east-1)"
  type        = string
}

variable "waf_name" {
  type = string
}

variable "cloudfront_name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
