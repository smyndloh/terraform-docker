resource "docker_image" "container_image" {
  #name = "nodered/node-red:latest"
  #name = "nodered/node-red:latest-minimal"
  name = var.image_in
} 