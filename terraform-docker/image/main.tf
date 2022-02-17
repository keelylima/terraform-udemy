# essa é a primeira imagem que eu criei, que aparece em images no docker desktop
resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"

}