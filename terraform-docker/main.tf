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

# aqui eu vou criar o container baseado na image que subi primeiro
resource "docker_container" "nodered_container" {
  name = "nodered2"
  # .latest é retirado do output do resource docker_image: https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/image
  image = docker_image.nodered_image.latest
  ports {
    internal = 1880
    external = 1880
  }
}

output "IPAddress" {
  value = docker_container.nodered_container.ip_address
  description = "IP Address"
}

output "Gateway" {
   value       = docker_container.nodered_container.network_data[0].gateway
   description = "Gateway"
}

output "Name" {
  value = docker_container.nodered_container.name
  description = "Name"
}

output "Image-ID" {
  value = docker_container.nodered_container.image
  description = "image"
}

output "Join" {
  value = join(":", [docker_container.nodered_container.ip_address, docker_container.nodered_container.ports[0].external])
  description = "Join"
}
