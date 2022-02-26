resource "random_string" "random" {
  count     = var.count_in
  length    = 5
  number    = true
  upper     = true
  min_lower = 5
  special   = false
}

resource "docker_container" "nodered_container" {
  count = var.count_in
  name  = join("-", [var.name_in, terraform.workspace, random_string.random[count.index].id])
  image = var.image_in
  ports {
    internal = var.int_port_in
    external = var.ext_port_in[count.index]
  }
  volumes {
    container_path = var.container_path_in
    volume_name    = docker_volume.container_volume[count.index].name
  }
}

resource "docker_volume" "container_volume" {
  count = var.count_in
  name  = "${var.name_in}-${random_string.random[count.index].result}-volume"
  lifecycle {
    prevent_destroy = false
  }
}