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
  type    = map
  
  validation {
    # não preciso usar [] porque o meu var.ext_port já é uma lista
    condition = max(var.ext_port["dev"]...) <= 65535 && min(var.ext_port["dev"]...) >= 1980
    error_message = "The external port must be in the valid port range 0 - 65535."
  }

    validation {
    # não preciso usar [] porque o meu var.ext_port já é uma lista
    condition = max(var.ext_port["prod"]...) <= 1980 && min(var.ext_port["prod"]...) >= 1880
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
  # lookup passo o nome do meu map, q á ext_port lá no tfvars, depois se passa key que eu defini aqui no variables como env
  # ele vai criar de acordo com a quantidade que eu tenho no ext_port
  count_resources = length(lookup(var.ext_port, var.env))
}

variable "int_port" {
  type    = number
  default = 1880

  validation {
    condition     = var.int_port == 1880
    error_message = "The port must to be 1880."
  }
}