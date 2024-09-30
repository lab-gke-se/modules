resource "google_compute_instance" "instance" {
  project                   = var.project
  allow_stopping_for_update = var.allow_stopping_for_update

  name                    = var.name
  description             = var.description
  machine_type            = var.machineType
  can_ip_forward          = var.canIpForward
  min_cpu_platform        = var.minCpuPlatform
  zone                    = reverse(split("/", var.zone))[0]
  tags                    = try(var.tags.items, null) != null ? var.tags.items : []
  deletion_protection     = var.deletionProtection
  resource_policies       = var.resourcePolicies
  metadata                = try(var.metadata.items, null) != null ? { for item in var.metadata.items : item.key => item.value } : {}
  metadata_startup_script = var.metadata_startup_script
  hostname                = var.hostname
  enable_display          = try(var.displayDevice.enableDisplay, null)


  # variable "startRestricted" {
  #   description = "Start Restricted"
  #   type        = bool
  #   default     = null
  # }

  # variable "sourceMachineImage" {
  #   description = "source machine image"
  #   type        = string
  #   default     = null
  # }

  dynamic "boot_disk" {
    for_each = try(var.disks, null) != null ? [for disk in var.disks : disk if disk.boot] : []

    content {
      auto_delete             = try(boot_disk.value.autoDelete, null)
      device_name             = try(boot_disk.value.deviceName, null)
      mode                    = try(boot_disk.value.mode, null)
      disk_encryption_key_raw = try(boot_disk.value.diskEncryptionKey.rawKey, null)
      kms_key_self_link       = try(boot_disk.value.diskEncryptionKey.kmsKeyName, null)
      source                  = "" #try(boot_disk.value.source, null)

      dynamic "initialize_params" {
        for_each = try(boot_disk.value.initializeParams, null) != null ? [boot_disk.values.initializeParams] : []

        content {
          size                        = try(initialize_params.value.diskSizeGb, null)
          type                        = try(initialize_params.value.type, null)
          image                       = try(initialize_params.value.source, null)
          labels                      = try(initialize_params.value.labels, null)
          resource_manager_tags       = try(initialize_params.value.resourceManagerTags, null)
          resource_policies           = try(initialize_params.value.resourcePolicies, null)
          provisioned_iops            = try(initialize_params.value.provisioned_iops, null)
          provisioned_throughput      = try(initialize_params.value.provisioned_throughput, null)
          enable_confidential_compute = try(initialize_params.value.enableConfidentialCompute, null)
          storage_pool                = try(initialize_params.value.storagePool, null)
        }
      }
    }
  }

  # dynamic "scratch_disk" {
  #   for_each = try(var.disks, null) != null ? [for disk in var.disks : disk if !disk.boot] : []

  #   content {
  #     interface = null
  #   }
  # }

  dynamic "attached_disk" {
    for_each = try(var.disks, null) != null ? [for disk in var.disks : disk if !disk.boot] : []

    content {
      source                  = attached_disk.value.source
      device_name             = try(attached_disk.value.deviceName)
      mode                    = try(attached_disk.value.mode)
      disk_encryption_key_raw = try(attached_disk.value.diskEncryptionKey.rawKey, null)
      kms_key_self_link       = try(attached_disk.value.diskEncryptionKey.kmsKeyName, null)
    }
  }

  dynamic "network_interface" {
    for_each = try(var.networkInterfaces, null) != null ? var.networkInterfaces : []

    content {
      network    = try(network_interface.value.network, null)
      subnetwork = try(network_interface.value.subnetwork, null)
      network_ip = try(network_interface.value.networkIP, null)
      nic_type   = try(network_interface.value.nicType, null)
      stack_type = try(network_interface.value.stackType, null)

      # subnetwork_project = try(network_interface.value.subnetworkProject, null) How to do this?
      #     ipv6Address              = optional(string, null)
      #     internalIpv6PrefixLength = optional(string, null)
      #     name                     = optional(string, null)
      #     fingerprint       = optional(string, null)
      # network_attachment = try(network_interface.value.networkAttachment, null) - beta
      #     ipv6AccessType    = optional(string, null)
      #     queyCount         = optional(number, null)
      #     nicType           = optional(string, null)
      #     networkAttachment = optional(string, null)

      dynamic "access_config" {
        for_each = try(network_interface.value.accessConfigs, null) != null ? [network_interface.value.accessConfigs] : []

        content {
          nat_ip                 = try(access_config.value.nat_ip, null)
          network_tier           = try(access_config.value.network_tier, null)
          public_ptr_domain_name = try(access_config.value.publicPtrDomainName, null)
          #       type                = optional(string, null)
          #       name                = optional(string, null)
          #       externalIpv6        = optional(string, null)
          #       setPublicPtr        = optional(bool, null)
          #       securityPolicy      = optional(string, null)
        }
      }

      dynamic "alias_ip_range" {
        for_each = try(network_interface.value.aliasRanges, null) != null ? [network_interface.value.aliasRanges] : []

        content {
          ip_cidr_range         = alias_ip_range.value.ipCidrRange
          subnetwork_range_name = try(alias_ip_range.value.subnetworkRangeName, null)
        }
      }

      dynamic "ipv6_access_config" {
        for_each = try(network_interface.value.ipv6AccessConfigs, null) != null ? [network_interface.value.ipv6AccessConfigs] : []

        content {
          name                        = try(ipv6_access_config.value.name, null)
          network_tier                = try(ipv6_access_config.value.networkTier, null)
          external_ipv6               = try(ipv6_access_config.value.externalIpv6, null)
          external_ipv6_prefix_length = try(ipv6_access_config.value.externalIpv6PrefixLength, null)
          public_ptr_domain_name      = try(ipv6_access_config.value.publicPtrDomainName, null)
          #       type                     = optional(string, null)
          #       name                     = optional(string, null)
          #       natIP                    = optional(string, null)
          #       externalIpv6PrefixLength = optional(number, null)
          #       setPublicPtr             = optional(bool, null)
          #       securityPolicy           = optional(string, null)
        }
      }
    }
  }

  # dynamic "service_account" {
  #   for_each = try(var.serviceAccounts, null) != null ? var.serviceAccounts : []

  #   content {
  #     email  = try(service_account.value.email, null)
  #     scopes = try(service_account.value.scopes, null)
  #   }
  # }

  dynamic "scheduling" {
    for_each = try(var.scheduling, null) != null ? [var.scheduling] : []

    content {
      on_host_maintenance = try(scheduling.value.onHostMaintenance, null)
      automatic_restart   = try(scheduling.value.automaticRestart, null)
      preemptible         = try(scheduling.value.preemptible, null)
      min_node_cpus       = try(scheduling.value.minNodeCpus, null)
      # location_hint = try(scheduling.value.locationHint, null)
      # availability_domain =     "availabilityDomain": integer,
      provisioning_model          = try(scheduling.value.provisioningModel, null)
      instance_termination_action = try(scheduling.value.instanceTerminationAction, null)
      # termination_time =     "terminationTime": string,
      # cpu_platform =  "cpuPlatform": string,

      dynamic "node_affinities" {
        for_each = try(scheduling.value.nodeAffinities, null) != null ? scheduling.valuenodeAffinities : []

        content {
          key      = node_affinities.value.key
          operator = node_affinities.value.operator
          values   = node_affinities.values
        }
      }

      dynamic "max_run_duration" {
        for_each = try(scheduling.value.maxRunDuration, null) != null ? [scheduling.value.maxRunDuration] : []

        content {
          seconds = max_run_duration.value.seconds
          nanos   = try(max_run_duration.value.nanos, null)
        }
      }

      dynamic "on_instance_stop_action" {
        for_each = try(scheduling.value.localSsdReonInstanceStopActioncoveryTimeout, null) != null ? [scheduling.value.onInstanceStopAction] : []

        content {
          discard_local_ssd = try(on_instance_stop_action.value.discardLocalSsd, null)
        }
      }

      dynamic "local_ssd_recovery_timeout" {
        for_each = try(scheduling.value.localSsdRecoveryTimeout, null) != null ? [scheduling.value.localSsdRecoveryTimeout] : []

        content {
          seconds = max_run_duration.value.seconds
          nanos   = try(max_run_duration.value.nanos, null)
        }
      }

      #   "labels": {
      #     string: string,
      #     ...
      #   },
      #   "params": {
      #     "resourceManagerTags": {
      #       string: string,
      #       ...
      #     }
      #   },
    }
  }

  # ??
  # dynamic "instance_encryption_key" {
  #   for_each = try(var.instanceEncryptionKey, null) != null ? [var.instanceEncryptionKey] : []

  #   content {
  #     raw_key                 = try(instance_encryption_key.value.rawKey, null)
  #     rsa_encrypted_key       = try(instance_encryption_key.value.rsaEncryptionKey, null)
  #     kms_key_name            = try(instance_encryption_key.value.kmsKeyName, null)
  #     sha256                  = try(instance_encryption_key.value.sha256, null)
  #     kms_key_service_account = try(instance_encryption_key.value.kmsKeyServiceAccount, null)
  #   }
  # }

  dynamic "guest_accelerator" {
    for_each = try(var.guestAccelerators, null) != null ? var.guestAccelerators : []

    content {
      type  = guest_accelerator.value.acceleratorType
      count = guest_accelerator.value.acceleratorCount
    }
  }

  dynamic "reservation_affinity" {
    for_each = try(var.reservationAffinity, null) != null ? [var.reservationAffinity] : []

    content {
      type = reservation_affinity.value.consumeReservationType

      dynamic "specific_reservation" {
        for_each = try(var.reservationAffinity.key, null) != null ? [var.reservationAffinity] : []

        content {
          key    = specific_reservation.value.key
          values = specific_reservation.value.values
        }
      }
    }
  }

  dynamic "shielded_instance_config" {
    for_each = try(var.shieldedInstanceConfig, null) != null ? [var.shieldedInstanceConfig] : []

    content {
      enable_secure_boot          = try(shielded_instance_config.value.enableSecureBoot, null)
      enable_vtpm                 = try(shielded_instance_config.value.enableVtpm, null)
      enable_integrity_monitoring = try(shielded_instance_config.value.enableIntegrityMonitoring, null)
    }
  }

  # ??
  # dynamic "shielded_instance_integrity_policy" {
  #   for_each = try(var.shieldedInstanceIntegrityPolicy, null) != null ? [var.shieldedInstanceIntegrityPolicy] : []

  #   content {
  #     update_auto_learn_policy = try(shielded_instance_integrity_policy.value.updateAutoLearnPolicy, null)
  #   }
  # }

  # ??
  # dynamic "source_machine_image_encryption_key" {
  #   for_each = try(var.sourceMachineImageEncryptionKey, null) != null ? [var.sourceMachineImageEncryptionKey] : []
  #   content {
  #     raw_key                 = try(source_machine_image_encryption_key.value.rawKey, null)
  #     rsa_encrypted_key       = try(source_machine_image_encryption_key.value.rsaEncryptedKey, null)
  #     kms_key_name            = try(source_machine_image_encryption_key.value.kmsKeyName, null)
  #     sha256                  = try(source_machine_image_encryption_key.value.sha256, null)
  #     kms_key_service_account = try(source_machine_image_encryption_key.value.kmsKeyServiceAccount, null)
  #   }
  # }

  dynamic "confidential_instance_config" {
    for_each = try(var.confidentialInstanceConfig, null) != null ? [var.confidentialInstanceConfig] : []

    content {
      enable_confidential_compute = try(confidential_instance_config.value.enableConfidentialCompute, null)
      confidential_instance_type  = try(confidential_instance_config.value.confidentialInstanceType, null)
    }

  }

  # privateIpv6GoogleAccess": enum,

  dynamic "advanced_machine_features" {
    for_each = try(var.advancedMachineFeatures, null) != null ? [var.advancedMachineFeatures] : []

    content {
      enable_nested_virtualization = try(advanced_machine_features.value.enableNestedVirtualization, null)
      threads_per_core             = try(advanced_machine_features.valuethreadsPerCore, null)
      visible_core_count           = try(advanced_machine_features.value.visibleCoreCount, null)
      # enable_uefi_networking = try( )"enableUefiNetworking": boolean,
      # "performanceMonitoringUnit": enum,
      # "turboMode": string
    }
  }

  # #   "lastStartTimestamp": string,
  # #   "lastStopTimestamp": string,
  # #   "lastSuspendedTimestamp": string,
  # #   "satisfiesPzs": boolean,
  # #   "satisfiesPzi": boolean,

  # dynamic "resource_status" {
  #   for_each = try(var.resourceStatus, null) != null ? [var.resourceStatus] : []

  #   content {
  #     physical_host = try(resource_status.value.physicalHost, null)

  #     dynamic "scheud"
  #     #     "scheduling": {
  #     #       "availabilityDomain": integer
  #     #     },
  #     #     "upcomingMaintenance": {
  #     #       "type": enum,
  #     #       "canReschedule": boolean,
  #     #       "windowStartTime": string,
  #     #       "windowEndTime": string,
  #     #       "latestWindowStartTime": string,
  #     #       "maintenanceStatus": enum
  #     #     },
  #     #     "physicalHost": string
  #   }
  # }

  # Beta
  # dynamic "network_performance_config" {
  #   for_each = try(var.networkPerformanceConfig, null) != null ? [var.networkPerformanceConfig] : []

  #   content {
  #     total_egress_bandwidth_tier = try(totalEgressBandwidthTier, null)
  #   }
  # }

  # ??
  # variable "keyRevocationActionType" {
  #   description = "Key Revocation Action Type"
  #   type        = string
  #   default     = null
  # }
}




