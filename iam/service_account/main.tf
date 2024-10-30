resource "google_service_account" "service_account" {
  project      = var.projectId
  account_id   = split("@", var.email)[0]
  display_name = var.displayName
  description  = var.description
  disabled     = var.disabled
}






