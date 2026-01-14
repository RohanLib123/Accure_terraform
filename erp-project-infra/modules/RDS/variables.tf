variable "db_name" {
  type        = string
  description = "Database name"
}

variable "db_subnet_group_name" {
  type        = string
  description = "Name of DB subnet group"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Private subnet IDs for RDS"
}

variable "security_group_ids" {
  type        = list(string)
  description = "RDS Security Groups"
}

variable "engine" {
  type        = string
  default     = "mysql"
  description = "RDS engine (mysql/postgresql)"
}

variable "engine_version" {
  type        = string
  default     = "8.0"
  description = "RDS engine version"
}

variable "instance_class" {
  type        = string
  default     = "db.t3.medium"
  description = "RDS instance class"
}

variable "username" {
  type        = string
  description = "Master DB username"
}

variable "password" {
  type        = string
  description = "Master DB password"
  sensitive   = true
}

variable "allocated_storage" {
  type        = number
  default     = 20
}

variable "storage_type" {
  type        = string
  default     = "gp3"
}

variable "multi_az" {
  type        = bool
  default     = true
}

variable "enable_read_replica" {
  type        = bool
  default     = true
}

variable "backup_retention_period" {
  type        = number
  default     = 7
}

variable "skip_final_snapshot" {
  type        = bool
  default     = true
}

variable "tags" {
  type    = map(string)
  default = {}
}
