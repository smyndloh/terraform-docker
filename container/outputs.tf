output "app_access" {
    value = {for x in docker_container.app_container[*]: x.name => join (":", [x.ip_address], x.ports[*]["external"])}
    description = "Container name & IP Address"
}

# output "ip_address" {
#     value = [for i in docker_container.nodered_container[*]: join(":", [i.ip_address],i.ports[*]["external"])]
#     value = 
#     description = "IP Address for the Container"
# }

# output "container_name" {
#     value = docker_container.nodered_container.name
#     description = "Container name"
# }



# output "ip_address" {
#     value = [for i in docker_container.nodered_container[*]: join(":", [i.ip_address],i.ports[*]["external"])]
#     description = "IP Address for the Container"
# }