output "volumes_output" {
    value = docker_volume.container_vol[*].name
    description = "Container volume name"
}
