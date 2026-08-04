output "instance_id" {
  value = aws_instance.demo-instance.id
}

output "instance_public_ip" {
  value = aws_instance.demo-instance.public_ip
}