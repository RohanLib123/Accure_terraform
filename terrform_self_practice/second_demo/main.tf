resource "aws_instance" "example" {
    ami = var.ami
    instance_type = var.instance_type   
    availability_zone = var.az_name[0]
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.example.id]
    subnet_id = aws_subnet.example.id
    cpu_options {
        core_count = 1
        threads_per_core = 1
    }
    disable_api_termination = false
    disable_api_stop = false
    
    


    

    tags = {
        Name = "Example_instance_01"
    }
  
}

resource "aws_vpc" "example" {
    cidr_block = var.vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
        Name = "Example_VPC_01"
    }
}



resource "aws_subnet" "example" {
    vpc_id = aws_vpc.example.id
    cidr_block = var.subnet_cidr
    availability_zone = var.az_name[0]
    map_public_ip_on_launch = true

    tags = {
        Name = "Example_Subnet_01"
    }
}

resource "aws_internet_gateway" "example" {
    vpc_id = aws_vpc.example.id

    tags = {
        Name = "Example_IGW_01"
    }
}

resource "aws_route_table" "example" {
    vpc_id = aws_vpc.example.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.example.id
    }
}   

resource "aws_route_table_association" "example" {
    subnet_id = aws_subnet.example.id
    route_table_id = aws_route_table.example.id
}

resource "aws_security_group" "example" {
    name = "example_sg"
    description = "Example security group"
    vpc_id = aws_vpc.example.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "Example_SG_01"
    }
}

