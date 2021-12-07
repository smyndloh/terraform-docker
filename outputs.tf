# output "container-name" {
#   value = docker_container.nodered_container[*].name
#   description = "Container Name"
# }

# output "ip-address" {
#   value = [for i in docker_container.nodered_container[*]: join(":", [i.ip_address],i.ports[*]["external"])]
#   description = "IP Add & external port of the container"
#  }
# output "ip-address" {
# #   value = join(":", docker_container.nodered_container[0].ip_address, docker_container.nodered_container[0].ports[0].external)
# #   description = "IP Add & external port of the container"
# # }