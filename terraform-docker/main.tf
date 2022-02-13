terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.15.0"
    }
  }
}

provider "docker" {
  host = "npipe:////.//pipe//docker_engine"
}

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

# essa é a primeira imagem que eu criei, que aparece em images no docker desktop
resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}

# Apesar do resource ser random, ele não cria um id diferente pra cada container, é preciso ter dois resources
resource "random_string" "random" {
  # sempre que trabalhamos com count, o state possui index, [0]
  count     = var.count_resources
  length    = 5
  number    = true
  upper     = true
  min_lower = 5
  special   = false
}

resource "docker_container" "nodered_container" {
  count = var.count_resources
  # para pegar o valor do index/indice que está passando na hora, se utiliza count.index
  name  = join("-", ["nodereeed", random_string.random[count.index].id])
  image = docker_image.nodered_image.latest
  ports {
    internal = var.int_port
    external = var.ext_port
  }
}

output "name" {
  value       = docker_container.nodered_container[*].name
  description = "container name"
}
