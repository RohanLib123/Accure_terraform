resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name = var.alarm_name
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 2
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = 60
  statistic = "Average"
  threshold = var.threshold
  alarm_actions = [var.sns_topic_arn]
  ok_actions = [var.sns_topic_arn]

  dimensions = {
    InstanceId = var.instance_id
  }

  tags = var.tags
}