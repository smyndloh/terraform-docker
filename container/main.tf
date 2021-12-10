
#Random Strings for Unique Names
resource "random_string" "random" {
  #for_each = local.deployment
  count   = var.count_in
  length  = 4
  special = false
  upper   = false
}

#Docker Container
resource "docker_container" "app_container" {
  count = var.count_in
  #name = var.name_in
  name  = join("-", [var.name_in, terraform.workspace, random_string.random[count.index].result])
  image = var.image_in
  ports {
    internal = var.int_port_in
    external = var.ext_port_in[count.index]
  }
  dynamic "volumes" {
    for_each = var.volumes_in
    content {
      container_path = volumes.value["container_path_each"]
      volume_name    = module.volume[count.index].volumes_output[volumes.key]
    }
  }
  provisioner "local-exec" {
    command = "echo ${join("-", [var.name_in, terraform.workspace, random_string.random[count.index].result])}: ${self.ip_address}:${join(":",var.ext_port_in[*])} >> ${path.cwd}/../backup/Containers.txt"
  }
  provisioner "local-exec" {
    when       = destroy
    command    = "mkdir ${path.cwd}/../backup/; rm -f ${path.cwd}/../backup/*.txt"
    on_failure = continue
  }
}

module "volume" {
  source = "./volume"
  count = var.count_in
  volume_count = length(var.volumes_in)
  volume_name = "${var.name_in}-${terraform.workspace}-${random_string.random[count.index].result}-volume"
}