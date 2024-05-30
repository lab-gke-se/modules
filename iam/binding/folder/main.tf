resource "google_folder_iam_binding" "binding" {
  folder  = var.folder
  role    = var.role
  members = var.members
}

