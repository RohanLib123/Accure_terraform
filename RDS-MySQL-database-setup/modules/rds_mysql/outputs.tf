output "endpoint" {
  value = aws_db_instance.rds.endpoint
}

output "port" {
  value = aws_db_instance.rds.port
}

output "instance_identifier" {
  value = aws_db_instance.rds.id
}

output "arn" {
  value = aws_db_instance.rds.arn
}

output "secret_arn" {
  value = local.secret_arn
}