resource "google_dns_managed_zone" "zone" {
  project     = var.project
  name        = var.name
  dns_name    = var.dns_name
  description = try(var.description, null) == "" ? null : try(var.description, null)
  labels      = try(var.labels, null)
  visibility  = try(var.visibility, null)

  dynamic "private_visibility_config" {
    for_each = lower(var.visibility) == "private" ? [var.private_visibility_config] : []

    content {
      dynamic "networks" {
        for_each = private_visibility_config.value.networks

        content {
          network_url = try(networks.value.networkUrl, null)
        }
      }
    }
  }
}
