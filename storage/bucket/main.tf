resource "google_storage_bucket" "bucket" {
  name                        = "${var.project}-${var.name}"
  project                     = var.project
  location                    = var.location
  force_destroy               = true
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"
  labels                      = var.labels

  versioning {
    enabled = var.versioning
  }

  encryption {
    default_kms_key_name = var.kms_key_id
  }

  /*
  dynamic "retention_policy" {
    for_each = lookup(local.data_classifications, var.data_classification, null)
    content {
      is_locked        = true
      retention_period = retention_policy.value
    }
  }
*/

  dynamic "logging" {
    for_each = var.log_bucket == null ? [] : [var.log_bucket]
    content {
      log_bucket = var.log_bucket
    }
  }
}

