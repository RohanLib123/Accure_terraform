resource "aws_iam_role" "ec2_role" {
  name = "ec2-cloudwatch-agent-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Principal = {
                Service = "ec2.amazonaws.com"
            }
        }
    ]
  })
}

resource "aws_iam_policy" "cw_policy" {
  name = "CloudWatchAgentPolicy"
  description = "EC2 permissions for CloudWatch Logs"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            Effect = "Allow"
            Action = [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "logs:DescribeLogStreams"
            ],
            Resource = "*"
        },
        {
            Effect = "Allow"
            Action = ["ssm:GetParameter"],
            Resource = "*"
        }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach" {
  role = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.cw_policy.arn
}

resource "aws_iam_instance_profile" "cw_instance_profile" {
  name = "cw-agent-instance-profile"
  role = aws_iam_role.ec2_role.name
}