resource "google_secret_manager_secret_version" "version" {
  secret = var.secret

  secret_data = var.secretData
  enabled     = var.enabled

  deletion_policy       = var.deletion_policy
  is_secret_data_base64 = var.is_secret_data_base64
}
