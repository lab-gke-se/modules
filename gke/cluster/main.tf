resource "google_container_cluster" "private" {
  for_each = { for subnet in var.subnetworks : subnet.name => subnet }

  name               = var.cluster_name
  location           = var.region
  network            = each.value.self_link
  subnetwork         = each.value.self_link
  enable_autopilot   = true
  initial_node_count = 1

  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes    = true
    master_ipv4_cidr_block  = var.gke_master_ipv4_cidr_block

    # master_authorized_networks_config {
    #   dynamic "cidr_blocks" {
    #     for_each = toset(var.authorized_source_ranges)
    #     content {
    #       cidr_block = cidr_blocks.value
    #     }
    #   }
    # }
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  release_channel {
    channel = "REGULAR"
  }

  depends_on = [google_service_account.gke_sa]
}

resource "google_service_account" "gke_sa" {
  for_each = { for sa in var.service_accounts : sa.name => sa }

  account_id   = each.value.name
  display_name = each.value.name
}