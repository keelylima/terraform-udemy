locals {
  deployment = {
    nodered = {
      image          = var.image["nodered"][terraform.workspace]
      int            = 1880
      ext            = var.ext_port["nodered"][terraform.workspace]
      container_path = "/data"
    }
    influxdb = {
      image          = var.image["influxdb"][terraform.workspace]
      int            = 8086
      ext            = var.ext_port["influxdb"][terraform.workspace]
      container_path = "/var/lib/influxdb"
    }
  }
}

module "image" {
  source   = "./image"
  for_each = local.deployment
  image_in = each.value.image
}

# Apesar do resource ser random, ele não cria um id diferente pra cada container, é preciso ter dois resources
resource "random_string" "random" {
  # sempre que trabalhamos com count, o state possui index, [0]
  for_each  = local.deployment
  length    = 5
  number    = true
  upper     = true
  min_lower = 5
  special   = false
}

module "container" {
  source            = "./container"
  for_each          = local.deployment
  name_in           = join("-", [each.key, terraform.workspace, random_string.random[each.key].id])
  image_in          = module.image[each.key].image_out
  int_port_in       = each.value.int
  ext_port_in       = each.value.ext[0]
  container_path_in = each.value.container_path
}

