data "archive_file" "lambda_zip" {
  type = "zip"
  source_file = "${path.module}/lambda_function.py"
  output_path = "${path.module}/lambda.zip"
}

resource "aws_lambda_function" "this_function" {
  function_name = var.lambda_name
  role = var.role_arn
  handler = "lambda_function.lambda_handler"
  runtime = var.runtime
  filename = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
}

