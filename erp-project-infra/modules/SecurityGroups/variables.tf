variable "sg_name" {
  type        = string
  description = "Name of the Security Group"
}

variable "sg_description" {
  type        = string
  description = "Description for Security Group"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where SG will be created"
}

variable "ingress_rules" {
  type = list(object({
    from_port      = number
    to_port        = number
    protocol       = string
    cidr_blocks    = optional(list(string), [])
    security_groups = optional(list(string), [])
    description    = optional(string)
  }))
  default = []
}

variable "egress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = optional(list(string), [])
    description = optional(string)
  }))
  default = []
}

variable "tags" {
  type        = map(string)
  default     = {}
}
