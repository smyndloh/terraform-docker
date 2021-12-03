variable "ext_port" {
    type = number
    default = 1990
    
    validation {
        condition = var.ext_port <=65535 && var.ext_port > 1880
        error_message = "The external port # must be in the range 1990-65535."
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