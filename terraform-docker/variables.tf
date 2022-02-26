variable "image" {
  type        = map(any)
  description = "image for container"
  default = {
    nodered = {
      dev  = "nodered/node-red:latest"
      prod = "nodered/node-red:latest-minimal"
    }
    influxdb = {
      dev  = "quay.io/influxdb/influxdb:v2.0.2"
      prod = "quay.io/influxdb/influxdb:v2.0.2"
    }
    grafana = {
      dev  = "grafana/grafana"
      prod = "grafana/grafana"
    }
  }
}

variable "ext_port" {
  type = map(any)

  # validation {
  #   # não preciso usar [] porque o meu var.ext_port já é uma lista
  #   condition     = max(var.ext_port["dev"]...) <= 65535 && min(var.ext_port["dev"]...) >= 1980
  #   error_message = "The external port must be in the valid port range 0 - 65535."
  # }

  # validation {
  #   # não preciso usar [] porque o meu var.ext_port já é uma lista
  #   condition     = max(var.ext_port["prod"]...) <= 1980 && min(var.ext_port["prod"]...) >= 1880
  #   error_message = "The external port must be in the valid port range 0 - 65535."
  # }
}

# nova forma com locals
# locals {
#   # com terraform workspace
#   # count_resources = length(lookup(var.ext_port, terraform.workspace))

#   # sem lookup
#   count_resources = length(var.ext_port[terraform.workspace])
# }

variable "int_port" {
  type    = number
  default = 1880

  validation {
    condition     = var.int_port == 1880
    error_message = "The port must to be 1880."
  }
}