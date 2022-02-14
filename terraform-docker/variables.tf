variable "ext_port" {
  type    = list
}

# forma antiga
# variable "count_resources" {
#   type    = number
#   default = 3
# }

# nova forma com locals
locals {
  count_resources = length(var.ext_port)
}

variable "int_port" {
  type    = number
  default = 1880

  validation {
    condition     = var.int_port == 1880
    error_message = "The port must to be 1880."
  }
}