resource "google_service_account_iam_binding" "binding" {
  service_account_id = var.service_account_id
  role               = var.role
  members            = var.members
}

