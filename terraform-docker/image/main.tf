# essa é a primeira imagem que eu criei, que aparece em images no docker desktop
resource "docker_image" "container_image" {
  name = var.image_in
} 