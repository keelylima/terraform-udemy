module "image" {
  source   = "./image"
  image_in = var.image[terraform.workspace]
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
  name  = join("-", ["nodereeed", terraform.workspace, random_string.random[count.index].id])
  image = module.image.image_out
  ports {
    internal = var.int_port
    # external = lookup(var.ext_port, terraform.workspace)[count.index]

    # sem o lookup
    external = var.ext_port[terraform.workspace][count.index]
  }
  volumes {
    container_path = "/data"
    #path.cwd pega D:/ ele reclama pq tem que ser um absolute path
    # host_path = "${path.cwd}/noderedvol"
  }
}

