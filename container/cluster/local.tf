data "google_container_engine_versions" "region" {
  location = var.location
  project  = var.project
}

# Probably want to give this a lot more thought
locals {
  min_master_version = (
    try(var.currentMasterVersion, null) != null ? var.currentMasterVersion :
    data.google_container_engine_versions.region.release_channel_latest_version.REGULAR
  )
  min_node_version = (
    try(var.currentNodeVersion, null) != null ? var.currentNodeVersion :
    data.google_container_engine_versions.region.release_channel_latest_version.REGULAR
  )
}

