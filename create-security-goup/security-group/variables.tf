variable "sg_name" {
  description = "Name of the security group"
  type = string
}

variable "sg_description" {
  description = "Description of the security group"
  type = string
  default = "Security group managed by terraform"
}

variable "vpc_id" {
  description = "VPC ID where SG will be created"
  type = string
}

#Ingress rules (list of objects)
variable "ingress_rules" {
  description = "list of ingress rules"
  type = list(object({
    description = string
    from_port =  number
    to_port = number
    protocol = string
    cidr_blocks = list(string)
  }))
}

#Egress rules (list of objects)
variable "egress_rules" {
  description = "list of egress rules"
  type = list(object({
    description = string
    from_port =  number
    to_port = number
    protocol = string
    cidr_blocks = list(string)
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
  description = "Environment tag (prod, dev, staging)"
  type = string
  default = "prod"
}