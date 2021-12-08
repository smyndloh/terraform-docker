#Create volume
resource "docker_volume" "container_vol" {
  #name = "${docker_container.nodered_container.name}-volume"
  name = "${var.name_in}-volume"
}

#Docker Container
resource "docker_container" "nodered_container" {
  name = var.name_in
  image = var.image_in
  ports {
    internal = var.int_port_in
    external = var.ext_port_in
  }
  volumes {
    volume_name = docker_volume.container_vol.name
    container_path = var.container_path_in
  }
}