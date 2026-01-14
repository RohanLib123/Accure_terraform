output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.this.domain_name
}

output "waf_arn" {
  value = aws_wafv2_web_acl.this.arn
}
