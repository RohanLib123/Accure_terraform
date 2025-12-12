output "lambda_function_name" {
  value = module.lambda.lambda_name
}

output "api_endpoint" {
  value = module.api_gateway.invoke_url
}

