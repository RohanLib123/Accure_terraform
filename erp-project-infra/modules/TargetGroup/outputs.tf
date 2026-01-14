output "target_group_arn" {
  value       = aws_lb_target_group.this.arn
  description = "ARN of the Target Group"
}

output "target_group_name" {
  value       = aws_lb_target_group.this.name
  description = "Name of the Target Group"
}
