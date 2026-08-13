variable "workspace_iam_roles" {
  default = {
    staging = "arn:aws:iam::732343865328:role/terraform-staging-role-01"
    production = "arn:aws:iam::732343865328:role/terraform-production-role-01"
  }
}