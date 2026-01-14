################################
# WAF Web ACL (CloudFront Scope)
################################
resource "aws_wafv2_web_acl" "this" {
  name  = var.waf_name
  scope = "CLOUDFRONT"

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = var.waf_name
    sampled_requests_enabled   = true
  }



################################
# Common Rule Set
################################
rule {
  name     = "AWSCommonRules"
  priority = 1

  override_action {
    none {}
  }

  statement {
    managed_rule_group_statement {
      name        = "AWSManagedRulesCommonRuleSet"
      vendor_name = "AWS"
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "CommonRules"
    sampled_requests_enabled   = true
  }
}


  ################################
# SQL Injection
################################
rule {
  name     = "SQLInjection"
  priority = 2

  override_action {
    none {}
  }

  statement {
    managed_rule_group_statement {
      name        = "AWSManagedRulesSQLiRuleSet"
      vendor_name = "AWS"
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "SQLiRules"
    sampled_requests_enabled   = true
  }
}


  ################################
# Bad IP Reputation
################################
rule {
  name     = "BadIPReputation"
  priority = 3

  override_action {
    none {}
  }

  statement {
    managed_rule_group_statement {
      name        = "AWSManagedRulesAmazonIpReputationList"
      vendor_name = "AWS"
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "BadIPRules"
    sampled_requests_enabled   = true
  }

}

}

################################
# CloudFront Distribution
################################
resource "aws_cloudfront_distribution" "this" {
  enabled             = true
  comment             = var.cloudfront_name
  default_root_object = "index.html"

  web_acl_id = aws_wafv2_web_acl.this.arn

  origin {
    domain_name = var.bucket_domain_name
    origin_id   = "s3-origin"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3-origin"

    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.acm_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  tags = var.tags
}

