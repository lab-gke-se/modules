resource "google_pubsub_subscription" "subscription" {
  project                      = var.project
  name                         = var.name
  topic                        = var.topic
  enable_exactly_once_delivery = var.enableExactlyOnceDelivery
  ack_deadline_seconds         = var.ackDeadlineSeconds
  labels                       = var.labels
  retain_acked_messages        = var.retainAckedMessages
  message_retention_duration   = var.messageRetentionDuration
  enable_message_ordering      = var.enableMessageOrdering
  filter                       = var.filter
  # detached ?
  # topicMessageRetentionDuration ?

  dynamic "push_config" {
    for_each = try(var.pushConfig, null) != null ? [var.pushConfig] : []

    content {
      push_endpoint = try(push_config.value.push_endpoint, null)
      attributes    = try(push_config.value.attributes, null)

      dynamic "oidc_token" {
        for_each = try(push_config.value.oidcToken, null) != null ? [push_config.value.oidcToken] : []

        content {
          service_account_email = oidc_token.value.serviceAccountEmail
          audience              = oidc_token.value.audience
        }
      }

      #   dynamic "pubsubWrapper" {
      #   }

      dynamic "no_wrapper" {
        for_each = try(push_config.value.no_wrapper, null) != null ? [push_config.value.no_wrapper, null] : []

        content {
          write_metadata = try(no_wrapper.value.writeMetadata, null)
        }
      }
    }
  }

  dynamic "bigquery_config" {
    for_each = try(var.bigqueryConfig, null) != null ? [var.bigqueryConfig] : []

    content {
      table                 = try(bigquery_config.value.table, null)
      use_topic_schema      = try(bigquery_config.value.useTopicSchema, null)
      write_metadata        = try(bigquery_config.value.writeMetadata, null)
      drop_unknown_fields   = try(bigquery_config.value.dropUnknownFields, null)
      use_table_schema      = try(bigquery_config.value.useTableSchema, null)
      service_account_email = try(bigquery_config.value.serviceAccountEmail, null)
    }
  }

  dynamic "cloud_storage_config" {
    for_each = try(var.cloudStorageConfig, null) != null ? [var.cloudStorageConfig, null] : []

    content {
      bucket                   = try(cloud_storage_config.value.bucket, null)
      filename_prefix          = try(cloud_storage_config.value.filenamePrefix, null)
      filename_suffix          = try(cloud_storage_config.value.filenameSuffix, null)
      filename_datetime_format = try(cloud_storage_config.value.filenameDatetimeFormat, null)
      max_duration             = try(cloud_storage_config.value.maxDuration, null)
      max_bytes                = try(cloud_storage_config.value.maxBytes, null)
      max_messages             = try(cloud_storage_config.value.maxMessages, null)
      service_account_email    = try(cloud_storage_config.value.serviceAccountEmail, null)
      #   dynamic "text_config" {}

      dynamic "avro_config" {
        for_each = try(cloud_storage_config.value.avroConfig, null) != null ? [cloud_storage_config.value.avroConfig] : []
        content {
          write_metadata   = avro_config.value.writeMetadata
          use_topic_schema = avro_config.value.useTopicSchema
        }
      }
    }
  }

  dynamic "expiration_policy" {
    for_each = try(var.expirationPolicy, null) != null ? [var.expirationPolicy] : []

    content {
      ttl = try(expariation_policy.value.ttl, null)
    }
  }

  dynamic "dead_letter_policy" {
    for_each = try(var.deadLetterPolicy, null) != null ? [var.deadLetterPolicy] : []

    content {
      dead_letter_topic     = try(dead_letter_policy.value.deadLetterTopic, null)
      max_delivery_attempts = try(dead_letter_policy.value.maxDeliveryAttempts, null)
    }
  }

  dynamic "retry_policy" {
    for_each = try(var.retryPolicy, null) != null ? [var.retryPolicy] : []

    content {
      minimum_backoff = try(retry_policy.value.minimumBackoff, null)
      maximum_backoff = try(retry_policy.value.maximumBackoff, null)
    }
  }

  dynamic "analytics_hub_subscription_info" {
    for_each = try(var.analyticsHubSubscriptionInfo, null) != null ? [var.analyticsHubSubscriptionInfo] : []

    content {
      listing      = try(analytics_hub_subscription_info.value.listing, null)
      subscription = try(analytics_hub_subscription_info.value.subscription, null)
    }

  }

}
