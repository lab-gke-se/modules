resource "google_compute_firewall" "rule" {
  project     = var.project
  name        = var.name
  description = var.description
  network     = var.network
  priority    = var.priority
  direction   = var.direction
  disabled    = var.disabled

  source_ranges      = var.source_ranges
  destination_ranges = var.destination_ranges

  dynamic "allow" {
    for_each = var.allowed != null ? var.allowed : []

    content {
      protocol = allow.value.IPProtocol
      ports    = try(allow.value.ports, null)
    }
  }

  dynamic "deny" {
    for_each = var.denied != null ? var.denied : []

    content {
      protocol = deny.value.IPProtocol
      ports    = try(deny.value.ports, null)
    }
  }

  dynamic "log_config" {
    for_each = var.log_config != null ? [var.log_config] : []

    content {
      metadata = try(log_config.value.metadata, "EXCLUDE_ALL_METADATA")
    }
  }
}
