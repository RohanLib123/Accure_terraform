variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ingress_rules" {
  description = "List of ingress rules objects: [{from_port=,to_port=,protocol=,cidr_blocks=[],source_sg_id=}]"
  type = list(object({
    from_port = number
    to_port = number
    protocol = string
    cidr_blocks = optional(lsit(string), [])
    source_sg_id = optional(string, null)
    description = optional(string, "") 
  }))
  default = []
}

variable "egress_rules" {
  type = list(object({
    from_port = number
    to_port = number
    protocol = string
    cidr_blocks = optional(lsit(string), [])
    description = optional(string, "") 
  }))
  default = []
}

variable "tags" {
  type = map(string)
  default = {}
}