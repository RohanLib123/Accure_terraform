variable "bucket_name" {
  description = "S3 bucket name for static website"
  type        = string
}

variable "index_document" {
  type    = string
  default = "index.html"
}

variable "error_document" {
  type    = string
  default = "error.html"
}

variable "tags" {
  type    = map(string)
  default = {}
}
