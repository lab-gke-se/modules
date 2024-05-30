resource "google_compute_network" "network" {
  project                                   = var.project
  name                                      = var.name
  description                               = var.description
  routing_mode                              = var.routing_mode
  delete_default_routes_on_create           = var.delete_default_routes
  mtu                                       = var.mtu
  enable_ula_internal_ipv6                  = var.ipv6_internal_enable
  internal_ipv6_range                       = var.ipv6_internal_range
  network_firewall_policy_enforcement_order = var.network_firewall_policy_enforcement_order
  auto_create_subnetworks                   = false
}

resource "google_compute_shared_vpc_host_project" "shared_vpc_host" {
  count   = var.shared_vpc_host ? 1 : 0
  project = var.project

  depends_on = [google_compute_network.network]
}
