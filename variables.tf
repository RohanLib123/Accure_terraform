variable "region" {
  description = "AWS Region for provide"
  type        = string
}

variable "ami" {
  description = "AMI ID for the instance"
  type        = string 
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
}

variable "az_name" {
  description = "Availability Zone for the EC2 instance"
  type        = string
}

variable "key_name" {
  description = "Key pair name for the EC2 instance"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet"
  type        = string

} 
