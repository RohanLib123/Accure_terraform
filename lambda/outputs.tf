output "lambda_function_name"{
    value = aws_lambda_function.lambda_fn.function_name
}

output "lambda_arn"{
    value = aws_lambda_function.lambda_fn.arn
}