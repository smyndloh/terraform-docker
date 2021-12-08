#Refrence our module/main.tf/image resource
module "image" {
  source = "./image"
  for_each = local.deployment
  image_in = each.value.image
  # image_in = var.image["nodered"][terraform.workspace]
}

# module "influxdb_image" {
#   source = "./image"
#   image_in = var.image["influxdb"][terraform.workspace]
# }

#Random Strings for Unique Names
resource "random_string" "random" {
  for_each = local.deployment
  length = 4
  special = false
  upper = false
}

# Container Module
module "container" {
  source ="./container"
  for_each = local.deployment
  #name_in = join("-", ["nodered", terraform.workspace, random_string.random[count.index].result])
  name_in = join ("-", [each.key, terraform.workspace, random_string.random[each.key].result])
  #image_in = module.image["nodered"].image_out
  image_in = module.image[each.key].image_out
  int_port_in = each.value.int
  ext_port_in = each.value.ext[0]
  container_path_in = each.value.container_path
}



# output "container-name" {
#   value = docker_container.nodered_container[*].name
#   description = "Container Name"
# }
