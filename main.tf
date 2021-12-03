#Create volume
resource "null_resource" "docker_vol" {
  provisioner "local-exec"{
    command = "mkdir noderedvol/ || true && sudo chown -R 1000:1000 noderedvol/"
  }
}

#Refrence our module/main.tf/image resource
module "image" {
  source = "./image"
}

#Random Strings for Unique Names
resource "random_string" "random" {
#  count = local.container_count
  count = 1
  length = 4
  special = false
  upper = false
}

#Docker Container
resource "docker_container" "nodered_container" {
  #count = local.container_count
  count = 1
  #name = join("-", ["nodered", terraform.workspace, random_string.random[count.index].result])
  name = join("-", ["nodered",random_string.random[count.index].result])
  #name = "nodered"
  image = module.image.image_out
  ports {
    internal = var.int_port
    #external = var.ext_port[terraform.workspace][count.index]
    external = var.ext_port
  }
  volumes {
    container_path = "/data"
    host_path = "${path.cwd}/noderedvol"
    #host_path = "/home/ubuntu/environment/terraform-docker/noderedvol"
  }
}


# output "container-name" {
#   value = docker_container.nodered_container[*].name
#   description = "Container Name"
# }