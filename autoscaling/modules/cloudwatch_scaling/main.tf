resource "aws_autoscaling_policy" "target_tracking" {
  name = "${var.asg_name}-cpu-target-tracking"
  autoscaling_group_name = var.asg_name
  policy_type = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = var.cpu_target_value
    disable_scale_in = var.disable_scale_in
  }
}

resource "aws_cloudwatch_metric_alarm" "high_cpu_alarm" {
  alarm_name = "${var.asg_name}-cpu-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = 2
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = 60
  statistic = "Average"
  threshold = var.step_upper_threshold
  dimensions = {
    AutoScalingGroupName = var.asg_name
  }
  alarm_actions = [aws_autoscaling_policy.step_up_policy.arn]
}

resource "aws_autoscaling_policy" "step_up_policy" {
  name = "${var.asg_name}-step-up"
  autoscaling_group_name = var.asg_name
  policy_type = "StepScaling"

  step_adjustment {
    scaling_adjustment = var.step_up_adjustment
    metric_interval_lower_bound = 0
  }
}

resource "aws_cloudwatch_metric_alarm" "low_cpu_alarm" {
  alarm_name = "${var.asg_name}-cpu-low"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = 2
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = 60
  statistic = "Average"
  threshold = var.step_lower_threshold
  dimensions = {
    AutoScalingGroupName = var.asg_name
  }
  alarm_actions = [aws_autoscaling_policy.step_down_policy.arn]
}

resource "aws_autoscaling_policy" "step_down_policy" {
  name = "${var.asg_name}-step-down"
  autoscaling_group_name = var.asg_name
  policy_type = "StepScaling"

  step_adjustment {
    scaling_adjustment = var.step_down_adjustment
    metric_interval_upper_bound = 0
  }
}