variable "alarm_name" {
  type = string
}

variable "instance_id" {
  type = string
}

variable "sns_topic_arn" {
  type = string
}

variable "threshold" {
  type = number
  default = 80
}

variable "tags" {
  type = map(string)
  default = {}
}