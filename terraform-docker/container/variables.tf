# como funciona?
    # meu root module, tem o module do container com os nomes da variavéis que estou passando aqui
    # ele procura apenas o nome aqui, se realmente existe esse "parâmetro", mas o valor é setado dentro do root module mesmo
variable "ext_port_in" {
    description = "external port"
}

variable "int_port_in" {
    description = "internal port"
}

variable "name_in" {
    description = "name container"
}

variable "image_in" {
    description = "image container"
}

variable "container_path_in" {
    description = "path container"
}