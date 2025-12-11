variable "environment" {
  type = string
}

variable "db_name" {
  type = string
}

variable "username" {
  type = string
  default = "admin"
}

variable "password_secret_arn" {
  type = string
  default = null
}

variable "engine" {
  type = string
  default = "mysql"
}

variable "engine_version" {
  type = string
  default = "8.0.34"
}

variable "instance_class" {
  type = string
  default = "db.t3.medium"
}

variable "allocated_storage" {
  type = number
  default = 20
}

variable "multi_az" {
  type = bool
  default = true    
}

variable "publicly_accessible" {
  type = bool
  default = false
}

variable "storage_encrypted" {
  type = bool
  default = true
}

variable "kms_key_id" {
  type = string
  default = null
}

variable "backup_retention_period" {
  type = number
  default = 7
}

variable "backup_window" {
  type = string
  default = "03:00-04:00"
}

variable "maintenance_window" {
  type = string
  default = "sun:05:00-sun:06:00"
}

variable "vpc_security_group_ids" {
  type = list(string)
}

variable "db_subnet_ids" {
  type = list(string)
}

variable "tags" {
  type = map(string)
  default = []
}
