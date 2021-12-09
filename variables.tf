variable "image" {
    type = map
    description = "image for container"
    default = {
    nodered = {
        dev = "nodered/node-red:latest-minimal"
        prod = "nodered/node-red:latest-minimal"
       }
    influxdb = {
        dev = "quay.io/influxdb/influxdb:v2.0.2"
        prod = "quay.io/influxdb/influxdb:v2.0.2"
       }
    }
}

variable "ext_port" {
    type = map
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
    type = number
    default = 1880
    
    validation {
        condition = var.int_port < 1881 && var.int_port > 0
        error_message = "The external port # must be in the range 0-1881."
    }
}

locals {
    deployment = {
        nodered = {
            container_count = length(var.ext_port["nodered"][terraform.workspace])
            image = var.image["nodered"][terraform.workspace]
            int = 1880
            ext = var.ext_port["nodered"][terraform.workspace]
            container_path = "/data"
           }
        influxdb = {
            container_count = length(var.ext_port["influxdb"][terraform.workspace])
            image = var.image["influxdb"][terraform.workspace]
            int = 8086
            ext = var.ext_port["influxdb"][terraform.workspace]
            container_path = "/var/lib/influxdb"
           }
    } #deployment
}


#local variables
# locals {
#     container_port = length(lookup(var.ext_port, terraform.workspace))
# }

# locals {
#     container_count = length(var.ext_port[terraform.workspace])
# }