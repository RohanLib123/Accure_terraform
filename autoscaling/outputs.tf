output "asg_name" {
  value = module.asg.asg_name
}

output "launch_template_id" {
  value = module.launch_template.launch_template_id
}

output "target_tracking_policy_arn" {
  value = module.cw_scaling.target_tracking_policy_arn
}