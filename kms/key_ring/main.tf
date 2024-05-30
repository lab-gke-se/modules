locals {
  random = random_string.suffix.result
}

resource "random_string" "suffix" {
  length  = 4
  upper   = false
  special = false
}

resource "google_kms_key_ring" "key_ring" {
  name     = "${var.name}-${local.random}"
  project  = var.project
  location = var.location
}
