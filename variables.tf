variable "entorno" {
  description = "Entorno de despliegue"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.entorno)
    error_message = "entorno debe ser dev, staging o prod."
  }
}

variable "proyecto" {
  type    = string
  default = "terraform-lab"
}

variable "configuracion_bucket" {
  description = "Configuración del bucket S3"
  type = object({
    versionado  = bool
    cifrado     = bool
    dias_expiry = number
  })
  default = {
    versionado  = true
    cifrado     = true
    dias_expiry = 90
  }

  validation {
    condition     = var.configuracion_bucket.dias_expiry >= 30
    error_message = "dias_expiry debe ser al menos 30 días."
  }
}