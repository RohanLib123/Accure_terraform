variable "region" {
  type = string
  default = "us-east-1"
}

variable "lambda_name" {
  type = string
  default = "myPythonLambda"
}

variable "lambda_runtime" {
  type = string
  default = "python3.12"
}

variable "api_name" {
  type = string
  default = "lambda-api"
}