variable "image" {
    type = map
    description = "image for container"
    default = {
        dev = "nodered/node-red:latest"
        prod = "nodered/node-red:latest-minimal"
    }
}

variable "ext_port" {
    #type = number
    type = map
    
    #Validation for DEV
    validation {
        condition = max(var.ext_port["dev"]...) <=65535 && min(var.ext_port["dev"]...) >= 1980
        error_message = "The external port # must be in the range 1980-65535."
    }
    
    #Validation for DEV
    validation {
        condition = max(var.ext_port["prod"]...) < 1980 && min(var.ext_port["prod"]...) >= 1880
        error_message = "The external port # must be in the range 1880-1979."
    }
    
}

variable "int_port" {
    type = number
    default = 1880
    
    validation {
        condition = var.int_port < 1881 && var.int_port > 0
        error_message = "The external port # must be in the range 0-1881."
    }
    
}

# variable "env" {
#     type = string
#     default = "dev"
#     description = "Environment to deploy to"
# }

#local variables
locals {
    container_port = length(lookup(var.ext_port, terraform.workspace))
}

locals {
    container_count = length(var.ext_port)
}