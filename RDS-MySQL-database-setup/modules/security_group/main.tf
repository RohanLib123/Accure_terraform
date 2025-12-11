resource "aws_security_group" "this_sg" {
  name = var.name
  description = "Managed by Terraform - ${var.name}"
  vpc_id = var.vpc_id

  tags = var.tags
}

resource "aws_security_group_rule" "ingress" {
  for_each = { for idx, r in var.ingress_rules : idx => r }
  type = "ingress"
  from_port = each.value.from_port
  to_port = each.value.to_port
  protocol = each.value.protocol 
  security_group_id = aws_security_group.this_sg.id

  cidr_blocks = lookup(each.value, "cidr_blocks", [])
  #source_security_group_id = lookup(each.value, "source_sg_id", null)
  description = lookup(each.value, "description", "")
}

resource "aws_security_group_rule" "egress" {
  for_each = { for idx, r in var.egress_rules : idx => r} 
  type = "egress"
  from_port = each.value.from_port
  to_port = each.value.to_port
  protocol = each.value.protocol
  cidr_blocks = lookup(each.value, "cidr_blocks", [])
  security_group_id = aws_security_group.this_sg.id
  description = lookup(each.value, "description", "")
}

