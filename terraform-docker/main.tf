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
  name = lookup(var.image, var.env)
}

# Apesar do resource ser random, ele não cria um id diferente pra cada container, é preciso ter dois resources
resource "random_string" "random" {
  # sempre que trabalhamos com count, o state possui index, [0]
  count     = local.count_resources
  length    = 5
  number    = true
  upper     = true
  min_lower = 5
  special   = false
}

resource "docker_container" "nodered_container" {
  count = local.count_resources
  # para pegar o valor do index/indice que está passando na hora, se utiliza count.index
  name  = join("-", ["nodereeed", random_string.random[count.index].id])
  image = docker_image.nodered_image.latest
  ports {
    internal = var.int_port
    external = var.ext_port[count.index]
  }
  volumes {
    container_path = "/data"
    #path.cwd pega D:/ ele reclama pq tem que ser um absolute path
    # host_path = "${path.cwd}/noderedvol"
  }
}

