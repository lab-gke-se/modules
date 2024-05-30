resource "google_project_iam_binding" "binding" {
  project = var.project
  role    = var.role
  members = var.members
}

