module "log_group" {
  source = "./modules/cloudwatch-logs"
  name = "/ec2/${var.instance_id}/system-logs"
  retention_in_days = 30
  tags = var.tags
}

module "sns_notification" {
  source = "./modules/sns-notification"
  topic_name = "ec2-alarm-topic"
  email = var.email
}

module "cpu_alarm" {
  source = "./modules/cpu-alarm"
  alarm_name = "high-cpu-${var.instance_id}"
  instance_id = var.instance_id
  sns_topic_arn = module.sns_notification.sns_topic_arn
  threshold = var.cpu_threshold
  tags = var.tags
}

module "iam_role" {
  source = "./modules/iam-cloudwatch-role"
  tags = var.tags
}

module "cw_agent" {
  source = "./modules/cloudwatch-agent"
  instance_id = var.instance_id
  log_group_name = module.log_group.log_group_name
}