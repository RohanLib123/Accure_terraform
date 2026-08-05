resource "aws_cloudwatch_metric_alarm" "demo_web_health" {
  evaluation_periods = 1
  alarm_name          = "demo_web_health"
  comparison_operator = "GreaterThanThreshold"
  threshold           = 80
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  statistic           = "Average"
  period              = 300

  dimensions = {
    InstanceId = var.instance_id
  }
}