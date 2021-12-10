#Create volume
resource "docker_volume" "container_vol" {
  count = var.volume_count
  name  = "${var.volume_name}-${count.index}"
  provisioner "local-exec" {
    when       = destroy
    command    = "sudo tar -czvf ${path.cwd}/../backup/${self.name}.tar.gz ${self.mountpoint}/"
    on_failure = fail
  }
}