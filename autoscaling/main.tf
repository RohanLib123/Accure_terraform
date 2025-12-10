locals {
  name_prefix = var.name_prefix
}

module "launch_template" {
  source = "./modules/launch_template"
  
  name_prefix = local.name_prefix
  ami_id = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_name
  iam_instance_profile = var.iam_instance_profile
  associate_public_ip = false
  security_group_ids = var.security_group_ids
  user_data = file("./userdata/bootstrap.sh")
  tags = var.tags
}

module "asg" {
  source = "./modules/asg"

  name = local.name_prefix
  launch_template_id = module.launch_template.launch_template_id
  launch_template_version = module.launch_template.launch_template_latet_version
  subnet_ids = var.vpc_subnet_ids
  min_size = var.asg_min
  max_size = var.asg_max
  desired_capacity = var.asg_desired
  tags_map = var.tags
}

module "cw_scaling" {
  source = "./modules/cloudwatch_scaling"

  asg_name = module.asg.asg_name
  cpu_target_value = 55
  step_upper_threshold = 80
  step_lower_threshold = 25
  step_up_adjustment = 1
  step_down_adjustment = -1
}