resource "google_storage_bucket" "bucket" {
  project       = var.project
  force_destroy = true

  enable_object_retention     = try(var.objectRetention.mode, null) == "Enabled"
  name                        = var.name
  labels                      = var.labels
  location                    = var.location
  public_access_prevention    = var.public_access_prevention
  storage_class               = var.default_storage_class
  uniform_bucket_level_access = var.uniform_bucket_level_access

  dynamic "encryption" {
    for_each = try(var.default_kms_key, null) != null ? [var.default_kms_key] : []

    content {
      default_kms_key_name = encryption.value
    }
  }

  dynamic "logging" {
    for_each = try(var.logging, null) != null ? [var.logging] : []

    content {
      log_bucket        = try(logging.value.logBucket, null)
      log_object_prefix = try(logging.value.logObjectPrefix, null)
    }
  }

  dynamic "retention_policy" {
    for_each = try(var.retentionPolicy.retentionPeriod, null) != null ? [var.retentionPolicy] : []

    content {
      is_locked        = try(retnetion_policy.value.is_locked, null)
      retention_period = retention_policy.value.retentionPeriod
    }
  }

  dynamic "soft_delete_policy" {
    for_each = try(var.softDeletePolicy, null) != null ? [var.softDeletePolicy] : []

    content {
      retention_duration_seconds = soft_delete_policy.value.retentionDurationSeconds
      effective_time             = soft_delete_policy.value.effectiveTime
    }
  }

  dynamic "versioning" {
    for_each = try(var.versioning_enabled, null) != null ? [var.versioning_enabled] : []

    content {
      enabled = versioning.value
    }
  }
}

