#Create volume
resource "null_resource" "docker_vol" {
  provisioner "local-exec"{
    command = "mkdir noderedvol/ || true && sudo chown -R 1000:1000 noderedvol/"
  }
}

#Refrence our module/main.tf/image resource
module "image" {
  source = "./image"
  image_in = var.image[terraform.workspace]
}

#Random Strings for Unique Names
resource "random_string" "random" {
  count = local.container_count
  #count = 1
  length = 4
  special = false
  upper = false
}

# Container Module
module "container" {
  source ="./container"
  depends_on = [null_resource.docker_vol]
  count = local.container_count
  name_in = join("-", ["nodered", terraform.workspace, random_string.random[count.index].result])
  image_in = module.image.image_out
  int_port_in = var.int_port
  ext_port_in = lookup(var.ext_port, terraform.workspace)[count.index]
  container_path_in = "/data"
  host_path_in = "${path.cwd}/noderedvol"
}



# output "container-name" {
#   value = docker_container.nodered_container[*].name
#   description = "Container Name"
# }
