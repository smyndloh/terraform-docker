#Create volume
resource "docker_volume" "container_vol" {
  count = var.count_in
  name = "${var.name_in}-${random_string.random[count.index].result}-volume"
}

#Random Strings for Unique Names
resource "random_string" "random" {
  #for_each = local.deployment
  count = var.count_in
  length = 4
  special = false
  upper = false
}

#Docker Container
resource "docker_container" "nodered_container" {
  count = var.count_in
  #name = var.name_in
  name = join ("-", [var.name_in, terraform.workspace, random_string.random[count.index].result])
  image = var.image_in
  ports {
    internal = var.int_port_in
    external = var.ext_port_in[count.index]
  }
  volumes {
    volume_name = docker_volume.container_vol[count.index].name
    container_path = var.container_path_in
  }
}