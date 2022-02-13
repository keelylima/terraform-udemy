variable "ext_port" {
  type    = number
  default = 1880
}

variable "count_resources" {
  type    = number
  default = 1
}

variable "int_port" {
  type    = number
  default = 1885

  validation {
    condition     = var.int_port == 1880
    error_message = "The port must to be 1880."
  }
}