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

# Container Module
module "container" {
  source ="./container"
  for_each = local.deployment
  count_in = each.value.container_count
  name_in = each.key
  #image_in = module.image["nodered"].image_out
  image_in = module.image[each.key].image_out
  int_port_in = each.value.int
  ext_port_in = each.value.ext
  container_path_in = each.value.container_path
}



# output "container-name" {
#   value = docker_container.nodered_container[*].name
#   description = "Container Name"
# }
