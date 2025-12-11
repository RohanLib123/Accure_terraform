terraform {
  backend "s3" {
    bucket = "test-terraform-bucket-training"
    key = "rds/mysql/prod/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt = true
  }
}