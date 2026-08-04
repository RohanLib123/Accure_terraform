variable "ami_id" {
  description = "AMI Id for an Instance"
  type = string

  validation {
    condition = length(var.ami_id) > 4 && substr(var.ami_id, 0, 4) == "ami-"
    error_message = "The image_id value must be a valid AMI ID, starting with \"ami-\"."
  }
}

variable "instance_type" {
  description = "The type of instance to start"
  type = string
}

variable "availability_zone" {
  description = "The availability zone to deploy the instance in"
  type = string
}

variable "key_name" {
  description = "The name of the key pair to use for the instance"
  type = string
}

variable "cpu_core_count" {
  description = "The number of CPU cores for the instance"
  type = number
}

variable "cpu_threads_per_core" {
  description = "The number of threads per CPU core for the instance"
  type = number
}

variable "security_group_id" {
  description = "The ID of the security group to associate with the instance"
  type = string
}

variable "subnet_id" {
  description = "The ID of the subnet to launch the instance in"
  type = string
}