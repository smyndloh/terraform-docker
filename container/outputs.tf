output "container_name" {
    value = docker_container.nodered_container.name
    description = "Container name"
}

output "ip_address" {
    value = [for i in docker_container.nodered_container[*]: join(":", [i.ip_address],i.ports[*]["external"])]
    description = "IP Address for the Container"
}