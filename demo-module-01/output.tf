output "instance_ip" {
    value = module.demo-instance.instance_public_ip
    description = "The public IP address of the EC2 instance"

}

output "instance_id" {
    value = module.demo-instance.instance_id
    description = "The ID of the EC2 instance"
}