resource "google_project_service_identity" "service_identity" {
  provider = google-beta

  project = var.project
  service = var.service
}
