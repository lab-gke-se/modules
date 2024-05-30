resource "google_organization_iam_binding" "binding" {
  org_id  = var.org_id
  role    = var.role
  members = var.members
}

