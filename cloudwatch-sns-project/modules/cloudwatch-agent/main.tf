resource "aws_ssm_parameter" "cw_agent_config" {
  name = "/cloudwatch=agent/config/${var.instance_id}"
  description = "Cloudwatch agent config for EC2 instance"
  type = "String"
  value = templatefile("${path.module}/cwagent.json", {log_group_name = var.log_group_name})
}

resource "aws_cloudwatch_log_group" "agent_log_group" {
  name = "/aws/amazon-cloudwatch-agent/${var.instance_id}"
  retention_in_days = 30
}

resource "aws_ssm_association" "cw_agent" {
  name = "AmazonCloudWatch-ManageAgent"
  targets {
    key = "InstanceIds"
    values = [var.instance_id]
  }

  parameters = {
    action = "configure"
    mode = "ec2"
    optionalConfig = aws_ssm_parameter.cw_agent_config.arn
  }
}