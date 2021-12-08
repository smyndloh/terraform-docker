#Refrence our module/main.tf/image resource
module "nodered_image" {
  source = "./image"
  image_in = var.image["nodered"][terraform.workspace]
}

module "influxdb_image" {
  source = "./image"
  image_in = var.image["influxdb"][terraform.workspace]
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
  count = local.container_count
  name_in = join("-", ["nodered", terraform.workspace, random_string.random[count.index].result])
  image_in = module.nodered_image.image_out
  int_port_in = var.int_port
  ext_port_in = var.ext_port[terraform.workspace][count.index]
  container_path_in = "/data"
}



# output "container-name" {
#   value = docker_container.nodered_container[*].name
#   description = "Container Name"
# }
