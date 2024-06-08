variable "buckets" {
  description = "A map of GCS bucket configurations"
  type = map(object({
    name                       = optional(string, "")
    location                   = string
    storage_class              = string
    force_destroy              = bool
    uniform_bucket_level_access = bool
    labels                     = map(string)

    lifecycle_rule = optional(object({
      action = object({
        type = string
        storage_class = optional(string)
      })
      condition = object({
        age = optional(number)
        created_before = optional(string)
        with_state = optional(string)
        matches_storage_class = optional(list(string))
      })
    }))

    cors = optional(object({
      origin          = list(string)
      method          = list(string)
      response_header = list(string)
      max_age_seconds = number
    }))

    website = optional(object({
      main_page_suffix = string
      not_found_page   = string
    }))

    logging = optional(object({
      log_bucket        = string
      log_object_prefix = string
    }))

    versioning = optional(object({
      enabled = bool
    }))
  }))
}
