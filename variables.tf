variable "image" {
  type        = map(any)
  description = "image for container"
  default = {
    nodered = {
      dev  = "nodered/node-red:latest-minimal"
      prod = "nodered/node-red:latest-minimal"
    }
    influxdb = {
      dev  = "quay.io/influxdb/influxdb:v2.0.2"
      prod = "quay.io/influxdb/influxdb:v2.0.2"
    }
    grafana = {
      dev  = "grafana/grafana-enterprise:8.2.0"
      prod = "grafana/grafana-enterprise:8.2.0"
    }
  }
}

variable "ext_port" {
  type = map(any)
  #Validation for DEV
  # validation {
  #     condition = max(var.ext_port["dev"]...) <=65535 && min(var.ext_port["dev"]...) >= 1980
  #     error_message = "The external port # must be in the range 1980-65535."
  # }

  #Validation for DEV
  # validation {
  #     condition = max(var.ext_port["prod"]...) < 1980 && min(var.ext_port["prod"]...) >= 1880
  #     error_message = "The external port # must be in the range 1880-1979."
  # }
}

variable "int_port" {
  type    = number
  default = 1880

  validation {
    condition     = var.int_port < 1881 && var.int_port > 0
    error_message = "The external port # must be in the range 0-1881."
  }
}
