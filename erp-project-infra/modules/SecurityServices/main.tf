##########################
# CloudTrail
##########################
resource "aws_cloudtrail" "all_regions" {
  name                          = var.cloudtrail_name
  is_multi_region_trail         = true
  include_global_service_events = true
  enable_log_file_validation    = true
  s3_bucket_name                = var.cloudtrail_s3_bucket
  cloud_watch_logs_group_arn    = var.cloudwatch_log_group_arn
  cloud_watch_logs_role_arn     = var.cloudwatch_role_arn

  depends_on = [aws_s3_bucket.cloudtrail_bucket]
}

resource "aws_s3_bucket" "cloudtrail_bucket" {
  bucket = var.cloudtrail_s3_bucket
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = var.tags
}

##########################
# GuardDuty
##########################
resource "aws_guardduty_detector" "this" {
  enable = true
}

##########################
# Security Hub
##########################
resource "aws_securityhub_account" "this" {
  depends_on = [aws_guardduty_detector.this]
}

##########################
# AWS Config
##########################
resource "aws_config_configuration_recorder" "this" {
  name     = "default"
  role_arn = var.config_role_arn

  recording_group {
    all_supported = true
    include_global_resource_types = true
  }
}

resource "aws_config_delivery_channel" "this" {
  name           = "default"
  s3_bucket_name = var.config_s3_bucket
}

resource "aws_config_configuration_recorder_status" "this" {
  name    = aws_config_configuration_recorder.this.name
  is_enabled = true
}
