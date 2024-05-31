resource "google_compute_subnetwork" "subnetwork" {
  for_each                   = var.subnets
  project                    = var.project
  network                    = var.network
  name                       = each.key
  description                = try(each.value.description, null)
  ip_cidr_range              = each.value.ip_cidr_range
  region                     = each.value.region
  private_ip_google_access   = try(each.value.private_ip_google_access, "false")
  private_ipv6_google_access = try(each.value.private_ipv6_google_access, null)
  purpose                    = try(each.value.purpose, null)
  role                       = try(each.value.role, null)
  stack_type                 = try(each.value.stack_type, null)
  ipv6_access_type           = try(each.value.ipv6_access_type, null)

  dynamic "secondary_ip_range" {
    for_each = try(each.value.secondary_ip_ranges, {})

    content {
      range_name    = secondary_ip_range.key
      ip_cidr_range = secondary_ip_range.value
    }
  }

  dynamic "log_config" {
    for_each = coalesce(lookup(each.value, "subnet_flow_logs", null), false) ? [{
      aggregation_interval = each.value.subnet_flow_logs_interval
      flow_sampling        = each.value.subnet_flow_logs_sampling
      metadata             = each.value.subnet_flow_logs_metadata
      filter_expr          = each.value.subnet_flow_logs_filter
      metadata_fields      = each.value.subnet_flow_logs_metadata_fields
    }] : []
    content {
      aggregation_interval = log_config.value.aggregation_interval
      flow_sampling        = log_config.value.flow_sampling
      metadata             = log_config.value.metadata
      filter_expr          = log_config.value.filter_expr
      metadata_fields      = log_config.value.metadata == "CUSTOM_METADATA" ? log_config.value.metadata_fields : null
    }
  }

}
