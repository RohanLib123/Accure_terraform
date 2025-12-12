output "lambda_name" {
  value = aws_lambda_function.this_function.function_name
}

output "lambda_arn" {
  value = aws_lambda_function.this_function.arn
}