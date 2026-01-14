# DB Subnet Group
resource "aws_db_subnet_group" "this" {
  name       = var.db_subnet_group_name
  subnet_ids = var.subnet_ids
  description = "RDS subnet group for ${var.db_name}"

  tags = var.tags
}

# Primary RDS Instance
resource "aws_db_instance" "primary" {
  identifier              = "${var.db_name}-primary"
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  db_name                 = var.db_name
  username                = var.username
  password                = var.password
  allocated_storage       = var.allocated_storage
  storage_type            = var.storage_type
  multi_az                = var.multi_az
  publicly_accessible     = false
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = var.security_group_ids
  backup_retention_period = var.backup_retention_period
  skip_final_snapshot     = var.skip_final_snapshot
  auto_minor_version_upgrade = true

  tags = var.tags
}

# Read Replica
resource "aws_db_instance" "read_replica" {
  count                   = var.enable_read_replica ? 1 : 0
  identifier              = "${var.db_name}-read-replica"
  instance_class          = var.instance_class
  engine                  = var.engine
  engine_version          = var.engine_version
  publicly_accessible     = false
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = var.security_group_ids
  replicate_source_db     = aws_db_instance.primary.id
  skip_final_snapshot     = var.skip_final_snapshot

  tags = merge(var.tags, { Role = "read-replica" })
}
