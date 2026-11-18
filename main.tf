locals {
  nombre_bucket = "${var.proyecto}-${var.entorno}-${random_id.sufijo.hex}"
  es_produccion = var.entorno == "prod"
}

resource "randon_id" "sufijo" {
  byte_length = 4
}

resource "aws_s3_bucket" "app" {
  bucket = local.nombre_bucket
  tags = {
    Enviroment = var.entorno
    ManagedBy  = "Terraform"
  }

  lifecycle {
    #En producción, evitar destrucción accidental
    prevent_destroy = false #poner true para prod real

    # Ignorar cambios en tags (otros sistemas los gestionan)
    ignore_changes = [tag]

    # Validar que el bucket tiene el nombre correcto
    precondition {
      condition     = startswith(local.nombre_bucket, var.proyecto)
      error_message = "El nombre del bucket debe comenzar con el nombre del proyecto"
    }

    postcondition {
      condition     = self.id == local.nombre_bucket
      error_message = "El ID del bucket no coincide con el nombre esperado."
    }

  }
}

