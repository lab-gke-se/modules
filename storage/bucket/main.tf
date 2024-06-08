resource "google_storage_bucket" "buckets" {
  for_each = { for k, v in var.buckets : k => v if v.name != "" }

  name               = each.value.name
  location           = each.value.location
  storage_class      = each.value.storage_class
  force_destroy      = each.value.force_destroy
  uniform_bucket_level_access = each.value.uniform_bucket_level_access

  labels = each.value.labels

  dynamic "lifecycle_rule" {
    for_each = each.value.lifecycle_rule != null ? [each.value.lifecycle_rule] : []
    content {
      action {
        type = lifecycle_rule.value.action.type
        storage_class = lifecycle_rule.value.action.storage_class
      }
      condition {
        age = lifecycle_rule.value.condition.age
        created_before = lifecycle_rule.value.condition.created_before
        with_state = lifecycle_rule.value.condition.with_state
        matches_storage_class = lifecycle_rule.value.condition.matches_storage_class
      }
    }
  }

  dynamic "cors" {
    for_each = each.value.cors != null ? [each.value.cors] : []
    content {
      origin          = cors.value.origin
      method          = cors.value.method
      response_header = cors.value.response_header
      max_age_seconds = cors.value.max_age_seconds
    }
  }

  dynamic "website" {
    for_each = each.value.website != null ? [each.value.website] : []
    content {
      main_page_suffix = website.value.main_page_suffix
      not_found_page   = website.value.not_found_page
    }
  }

  dynamic "logging" {
    for_each = each.value.logging != null ? [each.value.logging] : []
    content {
      log_bucket        = logging.value.log_bucket
      log_object_prefix = logging.value.log_object_prefix
    }
  }

  dynamic "versioning" {
    for_each = each.value.versioning != null ? [each.value.versioning] : []
    content {
      enabled = versioning.value.enabled
    }
  }
}
