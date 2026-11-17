variable "entorno" {
    description = "Entorno de despliegue"
    type = string
    default = "dev"

    validation {
        condition = contains(["dev", "staging", "prod"], var.entorno)
        error_message = "entorno debe ser dev, staging o prod."
    }
}
