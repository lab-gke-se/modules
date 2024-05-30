locals {
  random = random_string.suffix.result
}

resource "random_string" "suffix" {
  length  = 4
  upper   = false
  special = false
}

resource "google_project_iam_custom_role" "role" {
  project     = var.project
  role_id     = "${var.role_id}.${local.random}"
  title       = var.title
  description = var.description
  permissions = var.permissions
}
