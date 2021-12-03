# terraform {
#   required_providers {
#     docker = {
#       source = "kreuzwerker/docker"
#     }
#   }
# }

# provider "docker" {}

#Pull Image
resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
} 

#Create volume
resource "null_resource" "docker_vol" {
  provisioner "local-exec"{
    command = "mkdir noderedvol/ || true && sudo chown -R 1000:1000 noderedvol/"
  }
}

#Random Strings for Unique Names
resource "random_string" "random" {
  count = 1
  length = 4
  special = false
  upper = false
}

#Docker Container
resource "docker_container" "nodered_container" {
  count = 1
  name = join("-", ["nodered",random_string.random[count.index].result])
  #name = "nodered"
  image = docker_image.nodered_image.latest
  ports {
    internal = var.int_port
    external = var.ext_port
  }
  volumes {
    container_path = "/data"
    host_path = "/home/ubuntu/environment/terraform-docker/noderedvol"
  }
}


# output "container-name" {
#   value = docker_container.nodered_container[*].name
#   description = "Container Name"
# }