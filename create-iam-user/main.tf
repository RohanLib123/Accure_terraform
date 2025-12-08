terraform {
  required_providers{
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Create an IAM user
resource "aws_iam_user" "tester" {
  name = "tester-user"
  path = "/"
}

#Attach policy to user directly
resource "aws_iam_user_policy" "tester_policy" {
  name = "tester-inline-policy"
  user = aws_iam_user.tester.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
        {
            Action = [
                "ec2:Describe*",
                "s3:ListAllMyBuckets"
            ],
            Effect = "Allow",
            Resource = "*"
        }
    ]
  })
}