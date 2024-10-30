locals {
  project  = split("/", var.name)[1]
  location = split("/", var.name)[3]
  keyring  = split("/", var.name)[5]
}

resource "google_kms_key_ring" "key_ring" {
  project  = local.project
  location = local.location
  name     = local.keyring
}
