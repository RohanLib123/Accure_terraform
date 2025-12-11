resource "random_id" "suffix" {
  byte_length = 4
}   

variable "secret_name" {
  type = string
}
resource "aws_secretsmanager_secret" "db_secret" {
  count = var.password_secret_arn != "" ? 1 : 0
  #name = "rds/${var.environment}/${random_id.suffix.hex}"
  name = var.secret_name
  description = "RDS credentials for ${var.db_name} (${var.environment})"
  tags = merge({ Environment = var.environment}, var.tags)
}

resource "random_password" "password" {
  count = var.password_secret_arn == null ? 1 : 0
  length = 24
  special = true
}

resource "aws_secretsmanager_secret_version" "db_secret_value" {
  count = var.password_secret_arn == null ? 1 : 0
  secret_id = aws_secretsmanager_secret.db_secret[0].id
  secret_string = jsonencode({ username = var.username, password = random_password.password[0].result })
}

locals {
  secret_arn = var.password_secret_arn != null ? var.password_secret_arn : aws_secretsmanager_secret.db_secret[0].arn
  db_password = var.password_secret_arn != null ? null : random_password.password[0].result
}

resource "aws_db_subnet_group" "rds_subnet" {
  name = "rds-subnet-${var.environment}-${random_id.suffix.hex}"
  subnet_ids = var.db_subnet_ids
  tags = merge({ Name = "rds-subnet-${var.environment}" , Environment = var.environment }, var.tags)
}

resource "aws_db_parameter_group" "pg" {
  name = "mysql-pg-${var.environment}-${random_id.suffix.hex}"
  family = "mysql8.0"
  description = "MySQL parameter group for ${var.environment}"
  tags = merge({ Environment = var.environment }, var.tags)

  parameter {
    name = "slow_query_log"
    value = "1"
  }
}

resource "aws_db_instance" "rds" {
  identifier = "rds-${var.environment}-${random_id.suffix.hex}"
  allocated_storage = var.allocated_storage
  engine = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class
  db_name = var.db_name
  username = var.username
  password = local.db_password
  db_subnet_group_name = aws_db_subnet_group.rds_subnet.name
  vpc_security_group_ids = var.vpc_security_group_ids
  multi_az = var.multi_az
  publicly_accessible = var.publicly_accessible
  storage_encrypted = var.storage_encrypted
  kms_key_id = var.kms_key_id
  backup_retention_period = var.backup_retention_period
  backup_window = var.backup_window
  maintenance_window = var.maintenance_window
  deletion_protection = true
  skip_final_snapshot = true
  apply_immediately = false
  parameter_group_name = aws_db_parameter_group.pg.name
  enabled_cloudwatch_logs_exports = ["error","slowquery","general"]
  performance_insights_enabled = true
  tags = merge({ Name = "rds-${var.environment}", Environment = var.environment }, var.tags)
}

