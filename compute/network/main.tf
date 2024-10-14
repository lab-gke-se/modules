resource "google_compute_network" "network" {
  project                         = var.project
  delete_default_routes_on_create = var.delete_default_routes
  auto_create_subnetworks         = var.autoCreateSubnetworks

  name                                      = var.name
  description                               = var.description
  routing_mode                              = var.routingConfig.routingMode
  mtu                                       = var.mtu
  enable_ula_internal_ipv6                  = var.enableUlaInternalIpv6
  internal_ipv6_range                       = var.internalIpv6Range
  network_firewall_policy_enforcement_order = var.networkFirewallPolicyEnforcementOrder
}

resource "google_compute_shared_vpc_host_project" "shared_vpc_host" {
  count   = var.shared_vpc_host ? 1 : 0
  project = var.project

  depends_on = [google_compute_network.network]
}
