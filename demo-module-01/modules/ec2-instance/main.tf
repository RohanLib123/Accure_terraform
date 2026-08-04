resource "aws_instance" "demo-instance" {
    ami = var.ami_id
    instance_type = var.instance_type
    availability_zone = var.availability_zone
    key_name = var.key_name
    vpc_security_group_ids = [var.security_group_id]
    subnet_id = var.subnet_id
    cpu_options {
        core_count = var.cpu_core_count
        threads_per_core = var.cpu_threads_per_core
    }
    
    tags = {
        Name = "DemoInstance"
    }
  
}