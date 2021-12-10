locals {
  deployment = {
    # nodered = {
    #     container_count = length(var.ext_port["nodered"][terraform.workspace])
    #     image = var.image["nodered"][terraform.workspace]
    #     int = 1880
    #     ext = var.ext_port["nodered"][terraform.workspace]
    #     container_path = "/data"
    #   }
    influxdb = {
        container_count = length(var.ext_port["influxdb"][terraform.workspace])
        image = var.image["influxdb"][terraform.workspace]
        int = 8086
        ext = var.ext_port["influxdb"][terraform.workspace]
        #container_path = "/var/lib/influxdb"
        volumes = [
          { container_path_each = "/var/lib/influxdb" },
          { container_path_each = "/etc/influxdb" }
      ]
      }
    grafana = {
      container_count = length(var.ext_port["grafana"][terraform.workspace])
      image           = var.image["grafana"][terraform.workspace]
      int             = 3000
      ext             = var.ext_port["grafana"][terraform.workspace]
      volumes = [
        { container_path_each = "/var/lib/grafana" },
        { container_path_each = "/etc/grafana" }
      ]
    }
  } #deployment
}   #locals

#local variables
# locals {
#     container_port = length(lookup(var.ext_port, terraform.workspace))
# }

# locals {
#     container_count = length(var.ext_port[terraform.workspace])
# }