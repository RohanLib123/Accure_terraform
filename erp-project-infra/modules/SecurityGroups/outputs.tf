output "sg_id" {
  value       = aws_security_group.this.id
  description = "ID of the security group"
}

output "sg_name" {
  value       = aws_security_group.this.name
  description = "Name of the security group"
}
