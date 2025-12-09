output "log_group_name" {
  value = module.log_group.log_group_name
}

output "sns_topic_arn" {
  value = module.sns_notification.sns_topic_arn
}

output "cpu_alarm_name" {
  value = module.cpu_alarm.cpu_alarm_name
}