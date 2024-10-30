locals {
  project           = split("/", var.key_id)[1]
  identity_services = setsubtract(var.services, ["storage.googleapis.com", "bigquery.googleapis.com", "compute.googleapis.com"])

  crypters = concat(
    [for identity in module.service_identity : "serviceAccount:${identity.email}"],
    contains(var.services, "storage.googleapis.com") ? ["serviceAccount:${data.google_storage_project_service_account.account[0].email_address}"] : [],
    contains(var.services, "bigquery.googleapis.com") ? ["serviceAccount:${data.google_bigquery_default_service_account.account[0].email}"] : [],
    contains(var.services, "compute.googleapis.com") ? ["serviceAccount:service-${data.google_project.project.number}@compute-system.iam.gserviceaccount.com"] : []
  )
}

data "google_project" "project" {
  project_id = local.project
}

module "service_identity" {
  source   = "../../resources/service_identity"
  for_each = local.identity_services
  project  = local.project
  service  = each.value
}

data "google_storage_project_service_account" "account" {
  count   = contains(var.services, "storage.googleapis.com") ? 1 : 0
  project = local.project
}

data "google_bigquery_default_service_account" "account" {
  count   = contains(var.services, "bigquery.googleapis.com") ? 1 : 0
  project = local.project
}

resource "google_kms_crypto_key_iam_binding" "encrypters" {
  crypto_key_id = var.key_id
  role          = "roles/cloudkms.cryptoKeyEncrypter"
  members       = concat(var.encrypters, local.crypters)
}

resource "google_kms_crypto_key_iam_binding" "decrypters" {
  crypto_key_id = var.key_id
  role          = "roles/cloudkms.cryptoKeyDecrypter"
  members       = concat(var.decrypters, local.crypters)
}

