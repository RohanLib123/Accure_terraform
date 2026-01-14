output "instance_id" {
  value       = aws_instance.this.id
  description = "ID of the EC2 instance"
}

output "private_ip" {
  value       = aws_instance.this.private_ip
  description = "Private IP of the EC2 instance"
}

output "iam_role_name" {
  value       = aws_iam_role.this.name
  description = "IAM Role attached to EC2"
}
