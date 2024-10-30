resource "google_compute_disk" "disk" {
  project = var.project

  name                        = var.name
  labels                      = var.labels
  size                        = var.sizeGb
  physical_block_size_bytes   = var.physicalBlockSizeBytes
  source_disk                 = var.sourceDisk
  type                        = var.type
  image                       = var.sourceImage
  enable_confidential_compute = var.enableConfidentialCompute
  provisioned_iops            = var.provisionedIops
  provisioned_throughput      = var.provisionedThroughput
  licenses                    = var.licenses
  storage_pool                = var.storagePool
  access_mode                 = var.accessMode
  zone                        = split("/", var.zone)[8]
  snapshot                    = var.sourceSnapshot

  dynamic "async_primary_disk" {
    for_each = try(var.asyncPrimaryDisk.disk, null) != null ? [var.asyncPrimaryDisk] : []

    content {
      disk = async_primary_disk.value.disk
    }
  }

  dynamic "guest_os_features" {
    for_each = try(var.guestOsFeatures.type, null) != null ? var.guestOsFeatures : []

    content {
      type = guest_os_features.value.type
    }
  }

  dynamic "source_image_encryption_key" {
    for_each = try(var.sourceImageEncryptionKey, null) != null ? [var.sourceImageEncryptionKey] : []

    content {
      raw_key                 = try(source_image_encryption_key.value.rawKey, null)
      kms_key_self_link       = try(source_image_encryption_key.value.kmsKeyName, null)
      kms_key_service_account = try(source_image_encryption_key.value.kmsKeyServiceAccount, null)
    }
  }

  dynamic "disk_encryption_key" {
    for_each = try(var.diskEncryptionKey, null) != null ? [var.diskEncryptionKey] : []

    content {
      raw_key                 = try(disk_encryption_key.value.rawKey, null)
      rsa_encrypted_key       = try(disk_encryption_key.value.rsaEncryptedKey, null)
      kms_key_self_link       = try(disk_encryption_key.value.kmsKeyName, null)
      kms_key_service_account = try(disk_encryption_key.value.kmsKeyServiceAccount, null)
    }
  }

  dynamic "source_snapshot_encryption_key" {
    for_each = try(var.sourceSnapshotEncryptionKey, null) != null ? [var.sourceSnapshotEncryptionKey] : []

    content {
      raw_key                 = try(source_snapshot_encryption_key.value.rawKey, null)
      kms_key_self_link       = try(source_snapshot_encryption_key.value.kmsKeyName, null)
      kms_key_service_account = try(source_snapshot_encryption_key.value.kmsKeyServiceAccount, null)
    }
  }

  # Beta values
  # interface = var.interface 
  # resource_policies         = var.resourcePolicies
  # multi_writer = var.multiWriter
}
