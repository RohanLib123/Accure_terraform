output "primary_rds_endpoint" {
  value       = aws_db_instance.primary.endpoint
  description = "Primary RDS endpoint"
}

output "primary_rds_id" {
  value       = aws_db_instance.primary.id
  description = "Primary RDS instance ID"
}

output "read_replica_endpoint" {
  value       = aws_db_instance.read_replica[*].endpoint
  description = "Read replica endpoint"
}

output "db_subnet_group_name" {
  value       = aws_db_subnet_group.this.name
  description = "DB Subnet Group Name"
}
