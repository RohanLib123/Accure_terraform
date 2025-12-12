output "api_endpoint" {
  value = module.api_gateway.invoke_url
}

output "lambda_name" {
  value = module.lambda.lambda_name
}
