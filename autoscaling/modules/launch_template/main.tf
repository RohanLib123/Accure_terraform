resource "aws_launch_template" "this_template" {
  name_prefix = var.name_prefix
  image_id = var.ami_id
  instance_type = var.instance_type

  key_name = var.key_name

  iam_instance_profile {
    name = var.iam_instance_profile
  }

  network_interfaces {
    associate_public_ip_address = var.associate_public_ip
    security_groups = var.security_group_ids
  }

  user_data = var.user_data

  tag_specifications {
    #resource_type = "Instance"
    tags = merge(var.tags, { "Name" = "${var.name_prefix}-instance"})
  }

  lifecycle {
    create_before_destroy = true
  }
}