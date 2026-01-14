output "grafana_workspace_id" {
  value       = aws_grafana_workspace.this.id
  description = "Managed Grafana workspace ID"
}

output "grafana_endpoint" {
  value       = aws_grafana_workspace.this.endpoint
  description = "Grafana workspace URL"
}
