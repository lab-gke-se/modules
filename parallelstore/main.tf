resource "google_parallelstore_instance" "instance" {
  provider = google-beta

  project                = split("/", var.name)[1]
  location               = split("/", var.name)[3]
  instance_id            = split("/", var.name)[5]
  description            = var.description
  capacity_gib           = var.capacityGib
  network                = var.network
  reserved_ip_range      = var.reservedIpRange
  file_stripe_level      = var.fileStripeLevel
  directory_stripe_level = var.directoryStripeLevel
  labels                 = var.labels
}

