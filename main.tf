resource "aws_instance" "example" {
    ami = var.ami
    instance_type = var.instance_type   
    availability_zone = var.az_name
    key_name = var.key_name

    tags = {
        Name = "Example_instance_01"
    }
  
}