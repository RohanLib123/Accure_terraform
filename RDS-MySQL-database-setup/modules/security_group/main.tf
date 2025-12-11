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

  #cidr_blocks = lookup(each.value, "cidr_blocks", [])
  #source_security_group_id = lookup(each.value, "source_sg_id", null)
  description = lookup(each.value, "description", "")

  # ... other necessary arguments ...
  
  # 1. Define source_security_group_id:
  # Check if a source_sg_id is provided in the input map/object.
  source_security_group_id = (
    lookup(each.value, "source_sg_id", "") != "" 
    ? lookup(each.value, "source_sg_id", null) 
    : null
  )
  
  # 2. Define cidr_blocks:
  # Use CIDR blocks ONLY if source_security_group_id is NOT provided (i.e., 'source_sg_id' is null or empty).
  cidr_blocks = (
    lookup(each.value, "source_sg_id", "") == ""
    ? lookup(each.value, "cidr_blocks", []) # Fallback to CIDR blocks
    : null # Set to null if an SG ID is provided
  )
}


# You should define a local variable to simplify the check:
locals {
  # This evaluates to true if the source_sg_id field is present and non-empty
  source_sg_id_is_present = lookup(var.ingress_rules[each.key], "source_sg_id", "") != ""
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

