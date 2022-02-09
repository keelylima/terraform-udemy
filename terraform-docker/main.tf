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

# essa é a primeira imagem que eu criei, que aparece em images no docker desktop
resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}

# Apesar do resource ser random, ele não cria um id diferente pra cada container, é preciso ter dois resources
resource "random_string" "random" {
  count     = 3
  length    = 16
  number    = true
  upper     = true
  min_lower = 5
  special   = false
}

resource "docker_container" "nodered_container" {
  count = 3
  # para pegar o valor do index/indice que está passando na hora, se utiliza count.index
  name  = join("-", ["nodered", random_string.random[count.index].id])
  image = docker_image.nodered_image.latest
  ports {
    internal = 1880
    # external = 1880
  }
}

# para não duplicar, usamos o splat expression
output "name" {
  value = docker_container.nodered_container[*].name
  description = "name"
}

# sem o splat expression temos que criar dessa forma
# output "name-1" {
#   value       = docker_container.nodered_container[0].name
#   description = "name"
# }

# output "name-2" {
#   value       = docker_container.nodered_container[1].name
#   description = "name"
# }

# output "name-3" {
#   value       = docker_container.nodered_container[2].name
#   description = "name"
# }




























# Códigos comentados para estudo

# resource "random_string" "random_two" {
#   length    = 16
#   number    = true
#   upper     = true
#   min_lower = 5
#   special   = false
# }

# aqui eu vou criar o container baseado na image que subi primeiro
# resource "docker_container" "nodered_container" {
#   name = join("-", ["nodered", random_string.random.id])
#   # .latest é retirado do output do resource docker_image: https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/image
#   image = docker_image.nodered_image.latest
#   ports {
#     internal = 1880
#     # external = 1880
#   }
# }

# resource "docker_container" "nodered_container_two" {
#   name = join("-", ["nodered", random_string.random_two.id])
#   # .latest é retirado do output do resource docker_image: https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/image
#   image = docker_image.nodered_image.latest
#   ports {
#     internal = 1880
#     # external = 1880
#   }
# }


# output "container-one" {
#   value       = docker_container.nodered_container.name
#   description = "container-one"
# }

# output "container-two" {
#   value       = docker_container.nodered_container_two.name
#   description = "container-two"
# }


# output "IPAddress" {
#   value       = docker_container.nodered_container.ip_address
#   description = "IP Address"
# }

# output "Gateway" {
#   value       = docker_container.nodered_container.network_data[0].gateway
#   description = "Gateway"
# }

# output "Name" {
#   value       = docker_container.nodered_container.name
#   description = "Name"
# }

# output "Image-ID" {
#   value       = docker_container.nodered_container.image
#   description = "image"
# }

# output "Join" {
#   value       = join(":", [docker_container.nodered_container.ip_address, docker_container.nodered_container.ports[0].external])
#   description = "Join"
# }
