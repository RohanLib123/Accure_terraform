resource "aws_instance" "client" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  key_name = var.key_name
  user_data = var.user_data
  iam_instance_profile = var.iam_instance_profile_arn
  tags = merge({ Name = "rds-client" }, var.tags)
}

output "instacne_id" {
  value = aws_instance.client.id
}

output "public_ip" {
  value = aws_instance.client.public_ip
}

output "private_ip" {
  value = aws_instance.client.private_ip
}