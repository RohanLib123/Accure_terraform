#############################
# EC2 Detailed Monitoring
#############################
resource "aws_cloudwatch_metric_alarm" "ec2_cpu_high" {
  for_each = var.ec2_instance_ids

  alarm_name          = "${each.key}-High-CPU"
  alarm_description   = "Alarm when CPU exceeds ${var.ec2_cpu_threshold}%"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.ec2_eval_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.ec2_period
  statistic           = "Average"
  threshold           = var.ec2_cpu_threshold
  alarm_actions       = var.alarm_actions
  dimensions = {
    InstanceId = each.value
  }
}

#############################
# ALB Unhealthy Hosts
#############################
resource "aws_cloudwatch_metric_alarm" "alb_unhealthy_hosts" {
  for_each = var.alb_arns

  alarm_name          = "${each.key}-ALB-Unhealthy-Hosts"
  alarm_description   = "Alarm when ALB has unhealthy hosts"
  namespace           = "AWS/ApplicationELB"
  metric_name         = "UnhealthyHostCount"
  dimensions = {
    LoadBalancer = each.value
  }
  statistic           = "Average"
  period              = var.alb_period
  evaluation_periods  = var.alb_eval_periods
  threshold           = var.alb_unhealthy_threshold
  comparison_operator = "GreaterThanThreshold"
  alarm_actions       = var.alarm_actions
}
