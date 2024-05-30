locals {
  key_id = var.prevent_destroy ? google_kms_crypto_key.prod_key[0].id : google_kms_crypto_key.dev_key[0].id

  identity_services = setsubtract(var.services, ["storage.googleapis.com", "bigquery.googleapis.com", "compute.googleapis.com"])

  crypters = concat(
    [for identity in module.service_identity : "serviceAccount:${identity.email}"],
    contains(var.services, "storage.googleapis.com") ? ["serviceAccount:${data.google_storage_project_service_account.account[0].email_address}"] : [],
    contains(var.services, "bigquery.googleapis.com") ? ["serviceAccount:${data.google_bigquery_default_service_account.account[0].email}"] : [],
    contains(var.services, "compute.googleapis.com") ? ["serviceAccount:service-${var.project_number}@compute-system.iam.gserviceaccount.com"] : []
  )
}

module "service_identity" {
  source   = "../../resources/service_identity"
  for_each = local.identity_services
  project  = var.project
  service  = each.value
}

data "google_storage_project_service_account" "account" {
  count   = contains(var.services, "storage.googleapis.com") ? 1 : 0
  project = var.project
}

data "google_bigquery_default_service_account" "account" {
  count   = contains(var.services, "bigquery.googleapis.com") ? 1 : 0
  project = var.project
}

#checkov:skip=CKV_GCP_82:This key is for development of infrastructure only
resource "google_kms_crypto_key" "dev_key" {
  count                      = var.prevent_destroy ? 0 : 1
  name                       = var.name
  key_ring                   = var.key_ring
  rotation_period            = var.rotation_period
  destroy_scheduled_duration = var.destroy_scheduled_duration
  purpose                    = var.purpose
  labels                     = var.labels

  dynamic "version_template" {
    for_each = var.algorithm != null ? [1] : []

    content {
      algorithm        = var.algorithm
      protection_level = var.protection_level
    }
  }

  lifecycle {
    prevent_destroy = false
  }
}

resource "google_kms_crypto_key" "prod_key" {
  count                      = var.prevent_destroy ? 1 : 0
  name                       = var.name
  key_ring                   = var.key_ring
  rotation_period            = var.rotation_period
  destroy_scheduled_duration = var.destroy_scheduled_duration
  purpose                    = var.purpose
  labels                     = var.labels

  dynamic "version_template" {
    for_each = var.algorithm != null ? [1] : []

    content {
      algorithm        = var.algorithm
      protection_level = var.protection_level
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_kms_crypto_key_iam_binding" "encrypters" {
  crypto_key_id = local.key_id
  role          = "roles/cloudkms.cryptoKeyEncrypter"
  members       = concat(var.encrypters, local.crypters)
}

resource "google_kms_crypto_key_iam_binding" "decrypters" {
  crypto_key_id = local.key_id
  role          = "roles/cloudkms.cryptoKeyDecrypter"
  members       = concat(var.decrypters, local.crypters)
}

