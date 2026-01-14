# Grafana workspace
resource "aws_grafana_workspace" "this" {
  name                = var.name
  account_access_type = "CURRENT_ACCOUNT"
  authentication_providers = var.authentication_providers
  permission_type     = "SERVICE_MANAGED"
  role_arn            = var.iam_role_arn

  tags = var.tags
}

# CloudWatch data source
resource "aws_grafana_workspace_data_source" "cloudwatch" {
  workspace_id = aws_grafana_workspace.this.id
  name         = "CloudWatch"
  type         = "CLOUDWATCH"

  data_source_parameters {
    default_region = var.aws_region
  }
}
