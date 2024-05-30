locals {
  random = random_string.suffix.result
}

resource "random_string" "suffix" {
  length  = 4
  upper   = false
  special = false
}

resource "google_organization_iam_custom_role" "role" {
  org_id      = var.org_id
  role_id     = "${var.role_id}.${local.random}"
  title       = var.title
  description = var.description
  permissions = var.permissions
}
