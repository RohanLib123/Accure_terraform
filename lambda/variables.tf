variable "region" {
  description = "AWS region"
  type = string
  default = "us-east-1"
}

variable "lambda_name" {
  description = "Name of lambda function"
  type = string
}

variable "lambda_handler" {
  description = "Lambda handler"
  type = string
  default = "lambda.lambda_handler"
}

variable "runtime" {
  description = "Lambda runtime"
  type = string
  default = "python3.10"
}

variable "memory_size" {
  description = "Lambda RAM"
  type = number
  default = 128
}

variable "timeout" {
  description = "Lambda timeout (seconds)"
  type = number
  default = 5
}

variable "environment" {
  description = "Environment tag"
  type = string
  default = "prod"
}

variable "Project" {
  description = "Project name tag"
  type = string
  default = "serverless-app"
}

variable "environment_variables" {
  description = "Environment variables for lambda"
  type = map(string)
  default = {} 
}