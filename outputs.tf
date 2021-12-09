output "app-access" {
  value = [for x in module.container[*]: x]
  description = "Container name & Socket"
}


# output "container-name" {
#   value = module.container[*].container_name
#   description = "Container Name"
# }

# output "ip-address" {
#   value = flatten(module.container[*].ip_address)
#   description = "IP Add & external port of the container"
# }
 
 
 
 
# output "image-name" {
#   # for_each = local.deployment
#   value = module.image[keys(local.deployment)].image_out
#   description = "Image Name"
# }
# output "ip-address" {
# #   value = join(":", docker_container.nodered_container[0].ip_address, docker_container.nodered_container[0].ports[0].external)
# #   description = "IP Add & external port of the container"
# # }