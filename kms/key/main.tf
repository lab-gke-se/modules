locals {
  project  = split("/", var.name)[1]
  location = split("/", var.name)[3]
  keyring  = split("/", var.name)[5]
  key      = split("/", var.name)[7]
}

resource "google_kms_crypto_key" "key" {
  name                       = local.key
  key_ring                   = "projects/${local.project}/locations/${local.location}/keyRings/${local.keyring}"
  rotation_period            = var.rotationPeriod
  destroy_scheduled_duration = var.destroyScheduledDuration
  purpose                    = var.purpose
  labels                     = var.labels

  dynamic "version_template" {
    for_each = try(var.versionTemplate, null) != null ? [var.versionTemplate] : []

    content {
      algorithm        = try(version_template.value.algorithm, null)
      protection_level = try(version_template.value.protectionLevel, null)
    }
  }

  lifecycle {
    prevent_destroy = false
  }
}
