output "cloudtrail_id" {
  value       = aws_cloudtrail.all_regions.id
  description = "CloudTrail ID"
}

output "guardduty_detector_id" {
  value       = aws_guardduty_detector.this.id
  description = "GuardDuty detector ID"
}

output "securityhub_account_id" {
  value       = aws_securityhub_account.this.id
  description = "Security Hub account ID"
}

output "config_recorder_name" {
  value       = aws_config_configuration_recorder.this.name
  description = "AWS Config recorder name"
}
