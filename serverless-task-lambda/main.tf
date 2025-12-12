module "iam" {
  source = "./modules/iam"
}

module "lambda" {
  source = "./modules/lambda"
  lambda_name = var.lambda_name
  runtime = var.lambda_runtime
  role_arn = module.iam.lambda_role_arn
}

module "api_gateway" {
  source = "./modules/api_gateway"
  lambda_arn = module.lambda.lambda_arn
  api_name = var.api_name
}