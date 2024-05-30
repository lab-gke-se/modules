locals {
  random = random_string.suffix.result

  services = [
    for service in google_project_service.service : service.service
  ]
}

resource "random_string" "suffix" {
  length  = 4
  upper   = false
  special = false
}

# resource "google_project" "project" {
#   name                = var.name
#   project_id          = "${var.name}-${local.random}"
#   folder_id           = var.folder
#   billing_account     = var.billing_account
#   skip_delete         = false
#   auto_create_network = false
#   labels              = var.labels
# }

data "google_project" "project" {
  project_id = var.name
}

resource "google_project_default_service_accounts" "accounts" {
  project        = data.google_project.project.project_id
  action         = "DELETE"
  restore_policy = "NONE"
}

resource "google_project_service" "service" {
  for_each = var.services

  service                    = each.value
  project                    = data.google_project.project.project_id
  disable_on_destroy         = true
  disable_dependent_services = true
}

