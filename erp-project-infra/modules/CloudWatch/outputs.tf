output "ec2_cpu_alarms" {
  value       = [for a in aws_cloudwatch_metric_alarm.ec2_cpu_high : a.alarm_name]
  description = "List of EC2 CPU alarms"
}

output "alb_unhealthy_alarms" {
  value       = [for a in aws_cloudwatch_metric_alarm.alb_unhealthy_hosts : a.alarm_name]
  description = "List of ALB unhealthy host alarms"
}
