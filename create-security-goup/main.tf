module "web_sg"{
    source = "./security-group"

    sg_name = "prod-web-sg"
    sg_description = "security group for production web server"
    vpc_id = "vpc-0340d4162586e7b8d"

    ingress_rules = [
        {
            description = "Allow HTTP"
            from_port = 80
            to_port = 80
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        },
        {
            description = "Allow HTTPS"
            from_port = 443
            to_port = 443
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        },
        {
            description = "Allow SSH from admin office"
            from_port = 22
            to_port = 22
            protocol = "tcp"
            cidr_blocks = ["203.0.113.10/32"] #Restrict SSH
        }
    ]
}