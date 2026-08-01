variable "region" {
  description = "AWS Region for provide"
  type        = string
}

variable "ami" {
  description = "AMI ID for the instance"
  type        = string 

  validation {
    condition = length(var.ami) > 4 && substr(var.ami, 0, 4) == "ami-"
    error_message = "The image_id value must be a valid AMI ID, starting with \"ami-\"."
  }
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
}

variable "az_name" {
  description = "Availability Zone for the EC2 instance"
  type        = list(string)
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
