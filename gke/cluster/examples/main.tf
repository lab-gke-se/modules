provider "google" {
}

locals {
  config            = yamldecode(file("${path.module}/clusters.yaml"))
  random_suffix     = substr(md5(local.config.cluster_name), 0, 4)
  full_cluster_name = "${local.config.sector}-${local.config.app_id}-${local.config.env}-${local.config.cluster_name}-${local.random_suffix}"
}

module "gke_cluster" {
  source                     = "../modules/gke_cluster"
  project_id                 = local.config.project_id
  region                     = local.config.region
  cluster_name               = local.full_cluster_name
  gke_master_ipv4_cidr_block = local.config.gke_master_ipv4_cidr_block
  authorized_source_ranges   = local.config.authorized_source_ranges
  service_accounts           = local.config.service_accounts
  subnetworks                = local.config.subnetworks
}