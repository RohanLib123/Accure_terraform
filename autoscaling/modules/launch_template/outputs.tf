output "launch_template_id" {
  value = aws_launch_template.this_template.id
}

output "launch_template_latet_version" {
  value = aws_launch_template.this_template.latest_version
}