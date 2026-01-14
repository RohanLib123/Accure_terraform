# IAM Role
resource "aws_iam_role" "this" {
  name = var.iam_role_name

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

# IAM Policy Attachment
resource "aws_iam_role_policy_attachment" "this" {
  for_each = var.iam_policy_arns
  role     = aws_iam_role.this.name
  policy_arn = each.value
}

# EC2 Instance
resource "aws_instance" "this" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  associate_public_ip_address = false
  iam_instance_profile   = aws_iam_instance_profile.this.name
  key_name               = var.key_name

  tags = var.tags
}

# IAM Instance Profile
resource "aws_iam_instance_profile" "this" {
  name = "${var.iam_role_name}-profile"
  role = aws_iam_role.this.name
}
