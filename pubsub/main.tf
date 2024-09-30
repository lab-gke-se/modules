resource "google_pubsub_topic" "topic" {
  project                    = var.project
  name                       = var.name
  labels                     = var.labels
  kms_key_name               = var.kmsKeyName
  message_retention_duration = var.messageRetentionDuration

  dynamic "message_storage_policy" {
    for_each = try(var.messageStoragePolicy, null) != null ? [var.messageStoragePolicy] : []

    content {
      allowed_persistence_regions = message_storage_policy.value.allowedPersistenceRegions
      #   enforce_in_transit = message_storage_policy.value.enforceInTransit
    }
  }

  dynamic "schema_settings" {
    for_each = try(var.schemaSettings, null) != null ? [var.schemaSettings] : []
    content {
      schema   = schema_settings.value.schema
      encoding = schema_settings.value.encoding
    }
  }

  dynamic "ingestion_data_source_settings" {
    for_each = try(var.ingestionDataSourceSettings, null) != null ? [var.ingestionDataSourceSettings] : []

    content {
      dynamic "aws_kinesis" {
        for_each = try(ingestion_data_source_settings.value.awsKinesis, null) != null ? [ingestion_data_source_settings.value.awsKinesis] : []
        content {
          stream_arn          = aws_kinesis.value.streamArn
          consumer_arn        = aws_kinesis.value.consumerArn
          aws_role_arn        = aws_kinesis.value.awsRoleArn
          gcp_service_account = aws_kinesis.value.gcpServiceAccount
        }
      }
    }
  }
}
