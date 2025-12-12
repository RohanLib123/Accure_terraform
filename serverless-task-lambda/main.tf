module "iam" {
  source = "./modules/iam"
}

module "lambda" {
  source               = "./modules/lambda"
  lambda_name          = var.lambda_name
  runtime              = var.lambda_runtime
  role_arn             = module.iam.lambda_role_arn
}

module "api_gateway" {
  source        = "./modules/api_gateway"
  lambda_arn    = module.lambda.lambda_arn
  lambda_name   = module.lambda.lambda_name
  api_name      = var.api_name
}
