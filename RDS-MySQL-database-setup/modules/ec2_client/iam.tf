variable "secret_arn" {
  type = string
  default = null
}

resource "aws_iam_role" "ec2_role" {
  name = "ec2-secrets-reader-${replace(uuid(), "-", "")}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{ Effect = "Allow", Principal = { Service = "ec2.amazonaws.com" }, Action = "sts:AssumeRole" }]
  })
}

resource "aws_iam_policy" "read_secret" {
  name = "ec2-read-secret-policy-${replace(uuid(),"-","")}" 
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = ["secretsmanager:GetSecretValue","secretsmanager:DescribeSecret"],
       # Resource = var.secret_arn != null ? var.secret_arn : "*"
       Resource = "*"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "profile" {
  name = "ec2-profile-${replace(uuid(),"-","")}" 
  role = aws_iam_role.ec2_role.name
}

output "instance_profile_arn" {
  value = aws_iam_instance_profile.profile.arn
}