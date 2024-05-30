resource "google_service_account" "service_account" {
  account_id   = var.name
  project      = var.project
  display_name = var.display_name
  description  = var.description
  disabled     = var.disabled
}
