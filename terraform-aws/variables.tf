# -- root/variables.tf -- #

variable "aws_region" {
  default     = "us-east-1"
  description = "AWS Region"
}

variable "access_ip" {
  type = string
}
