locals {
  random      = random_string.suffix.result
  permissions = yamldecode(file("${path.module}/../permissions.yaml"))
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
  permissions = setsubtract(var.permissions, setunion(local.permissions.unsupported, local.permissions.nonproject))
}
