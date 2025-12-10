resource "aws_autoscaling_group" "this_asg" {
  name = var.name
  max_size = var.max_size
  min_size = var.min_size
  desired_capacity = var.desired_capacity
  vpc_zone_identifier = var.subnet_ids
  health_check_type = var.health_check_type
  health_check_grace_period = var.health_check_grace_period

  launch_template {
    id = var.launch_template_id
    version = var.launch_template_version
  }

  tag {
    key = "Name"
    value = var.name
    propagate_at_launch = true
  }

 #  tags = var.tags_map

  force_delete = false

  lifecycle {
    create_before_destroy = true
  }
}

