resource "aws_security_group" "this-group" {
  name = var.sg_name
  description = var.sg_description
  vpc_id = var.vpc_id

  # Allow multiplr ingress rule
  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      description = ingress.value.description
      from_port = ingress.value.from_port
      to_port = ingress.value.to_port
      protocol = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  # Default: Allow all outbound rule
  dynamic "egress" {
    for_each = var.egress_rules
    content {
      description = egress.value.description
      from_port = egress.value.from_port
      to_port = egress.value.to_port
      protocol = egress.value.to_port
      cidr_blocks = egress.value.cidr_blocks
    }
}

tags = {
  Name = var.sg_name
  Environment = var.environment
  ManagedBy = "Terraform"
}
