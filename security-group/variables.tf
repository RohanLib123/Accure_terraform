variable "sg_name" {
  description = "test-terra-sg"
  type = string
}

variable "sg_description" {
  description = "allow using terraform"
  type = string
  default = "Security group managed by terraform"
}

variable "vpc_id" {
  description = "vpc-0340d4162586e7b8d"
  type = string
}

#Ingress rules (list of objects)
variable "ingress_rules" {
  description = "list of ingress rules"
  type = list(object({
    description = "Allow HTTP"
    from_port =  80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }))
}

#Egress rules (list of objects)
variable "egress_rules" {
  description = "list of egress rules"
  type = list(object({
    description = "Allow HTTP"
    from_port =  80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }))
  default = [ {
    description = "Allow all outbound"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  } ]
}

variable "environment" {
  description = "prod"
  type = string
  default = "prod"
}