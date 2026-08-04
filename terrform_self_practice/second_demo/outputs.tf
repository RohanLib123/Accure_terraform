output "instance_ip" {
  value = aws_instance.example.public_ip
  description = "The public IP address of the EC2 instance"
  depends_on = [aws_security_group_rule.local_access]

  precondition {
    condition = length([for rule in aws_security_group.example.ingress : rule if rule.to_port == 80 || rule.to_port == 443]) > 0
    error_message = "The security group must allow HTTP (port 80) or HTTPS (port 443) traffic."
  } 
}

