variable "env" {
  type = string
  description = "env to deploy to"
  default = "dev"
}

variable "image" {
  type = map
  description = "image for container"
  default = {
    dev = "nodered/node-red:latest"
    prod = "nodered/node-red:latest-minimal"
  }
}

variable "ext_port" {
  type    = list
  validation {
    # não preciso usar [] porque o meu var.ext_port já é uma lista
    condition = max(var.ext_port...) <= 65535 && min(var.ext_port...) > 0
    error_message = "The external port must be in the valid port range 0 - 65535."
  }
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