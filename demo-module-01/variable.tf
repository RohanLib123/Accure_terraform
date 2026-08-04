variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "aws_access_key" {
  description = "The AWS access key for authentication"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "The AWS secret key for authentication"
  type        = string
  sensitive   = true
}

variable "ami_id" {
  description = "The ID of the AMI to use for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance to launch"
  type        = string
}

variable "availability_zone" {
  description = "The availability zone for the EC2 instance"
  type        = string
}

variable "key_name" {
  description = "The name of the SSH key pair to use for the EC2 instance"
  type        = string
}

variable "cpu_core_count" {
  description = "The number of CPU cores for the EC2 instance"
  type        = number
}

variable "cpu_threads_per_core" {
  description = "The number of threads per CPU core for the EC2 instance"
  type        = number
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "subnet_cidr" {
  description = "The CIDR block for the subnet"
  type        = string
}

