module "nodered_image" {
  source   = "./image"
  image_in = var.image["nodered"][terraform.workspace]
}

module "influxdb_image" {
  source   = "./image"
  image_in = var.image["influxdb"][terraform.workspace]
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

module "container" {
  source = "./container"
  # permaneço count aqui, porque quero replicar múltiplos módulos, não quero replicar múltiplos containers e depois múltiplos módulos
  count = local.count_resources
  # para pegar o valor do index/indice que está passando na hora, se utiliza count.index
  name_in           = join("-", ["nodereeed", terraform.workspace, random_string.random[count.index].id])
  image_in          = module.nodered_image.image_out
  int_port_in       = var.int_port
  ext_port_in       = var.ext_port[terraform.workspace][count.index]
  container_path_in = "/data"
  #path.cwd pega D:/ ele reclama pq tem que ser um absolute path
  # host_path = "${path.cwd}/noderedvol"
}

