output "security_group_id" {
  value = aws_security_group.this_sg.id
}

output "security_group_arn" {
  value = aws_security_group.this_sg.arn
}