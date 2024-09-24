resource "google_compute_subnetwork" "subnetwork" {
  project = var.project
  network = var.network

  name                       = var.name
  description                = var.description
  ip_cidr_range              = var.ipCidrRange
  region                     = reverse(split("/", var.region))[0]
  private_ip_google_access   = var.privateIpGoogleAccess
  private_ipv6_google_access = var.privateIpv6GoogleAccess
  purpose                    = var.purpose
  role                       = var.role
  stack_type                 = var.stackType
  ipv6_access_type           = var.ipv6AccessType
  external_ipv6_prefix       = var.externalIpv6Prefix

  # reserved_internal_range = var.reservedInternalRange ??
  # send_secondary_ip_range_if_empty??

  dynamic "secondary_ip_range" {
    for_each = coalesce(try(var.secondaryIpRanges, null), [])

    content {
      range_name    = secondary_ip_range.value.rangeName
      ip_cidr_range = secondary_ip_range.value.ipCidrRange
      # reserved_internal_range = secondary_ip_range.value.reservedInternalRange ??
    }
  }

  dynamic "log_config" {
    for_each = coalesce(try(var.logConfig.enabled, null), false) ? [var.logConfig] : []

    content {
      aggregation_interval = log_config.value.aggregationInterval
      flow_sampling        = log_config.value.flowSampling
      metadata             = log_config.value.metadata
      metadata_fields      = log_config.value.metadata == "CUSTOM_METADATA" ? log_config.value.metadataFields : null
      filter_expr          = log_config.value.filterExpr
    }
  }
}
