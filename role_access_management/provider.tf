provider "aws" {
    assume_role {
      role_arn = var.workspace_iam_roles[terraform.workspace]
    }
  
}