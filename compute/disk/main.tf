resource "google_compute_disk" "disk" {
  project = var.project
  name    = var.name
  type    = try(var.type, null)
  zone    = try(var.zone, null)
  size    = try(var.sizeGb, null)
}

