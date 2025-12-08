terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# IAM Role for lambda
resource "aws_iam_role" "lambda_role" {
  name = "${var.lambda_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
            Service = "lambda.amazonaws.com"
        }
    }]
  })
}

# Attach aws basic lambda execution policy
resource "aws_iam_role_policy_attachment" "basic_execution" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role = aws_iam_role.lambda_role.name
}

#Build lambda zip file
data "archive_file" "lambda_zip" {
  type = "zip"
  source_dir = "${path.module}/lambda_src"
  output_path = "${path.module}/lambda.zip"
}

#lambda Function
resource "aws_lambda_function" "lambda_fn" {
  function_name = var.lambda_name
  role = aws_iam_role.lambda_role.arn
  handler = var.lambda_handler
  runtime = var.runtime
  filename = data.archive_file.lambda_zip.output_path

  memory_size = var.memory_size
  timeout = var.timeout

  environment {
    variables = var.environment_variables
  }

  tags = {
    Environment = var.environment
    ManagedBy = "Terraform"
    Project = var.Project
  }
}