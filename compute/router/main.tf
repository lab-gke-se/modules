resource "google_compute_router" "router" {
  project                       = var.project
  name                          = var.name
  description                   = var.description
  network                       = var.network
  region                        = split("/", var.region)[8]
  encrypted_interconnect_router = var.encryptedInterconnectRouter

  dynamic "bgp" {
    for_each = try(var.bgp, null) != null ? [var.bgp] : []

    content {
      asn                = bgp.value.asn
      advertise_mode     = bgp.value.advertiseMode
      advertised_groups  = bgp.value.advertisedGroups
      keepalive_interval = bgp.value.keepaliveInterval
      identifier_range   = bgp.value.identifierRange

      dynamic "advertised_ip_ranges" {
        for_each = try(bgp.value.advertisedIpRanges, null) != null ? [bgp.value.advertisedIpRanges] : []

        content {
          range       = advertised_ip_ranges.value.range
          description = advertised_ip_ranges.value.description
        }
      }
    }
  }
}
