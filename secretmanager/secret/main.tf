resource "google_secret_manager_secret" "secret" {
  project         = var.project
  secret_id       = reverse(split("/", var.name))[0]
  labels          = var.labels
  annotations     = var.annotations
  version_aliases = var.versionAliases
  ttl             = var.ttl
  expire_time     = var.expireTime

  dynamic "replication" {
    for_each = coalesce(try([var.replication], null), [])

    content {

      # dynamic "auto" {
      #   for_each = coalesce(try([replication.value.automatic], null), [])

      #   content {
      #     dynamic "customer_managed_encryption" {
      #       for_each = coalesce(try([auto.value.customerManagedEncryption], null), [])

      #       content {
      #         kms_key_name = customer_managed_encryption.value.kmsKeyName
      #       }
      #     }
      #   }
      # }

      dynamic "user_managed" {
        for_each = coalesce(try([replication.value.userManaged], null), [])

        content {

          dynamic "replicas" {
            for_each = coalesce(try(user_managed.value.replicas, null), [])

            content {
              location = replicas.value.location

              dynamic "customer_managed_encryption" {
                for_each = coalesce(try([replicas.value.customerManagedEncryption], null), [])

                content {
                  kms_key_name = customer_managed_encryption.value.kmsKeyName
                }
              }
            }
          }
        }
      }
    }
  }

  dynamic "topics" {
    for_each = coalesce(try(var.topics, null), [])

    content {
      name = topics.value.name
    }
  }

  dynamic "rotation" {
    for_each = var.rotation != null ? [var.rotation] : []

    content {
      next_rotation_time = try(rotation.value.next_rotation_time, null)
      rotation_period    = try(rotation.value.rotation_period, null)
    }
  }
}

