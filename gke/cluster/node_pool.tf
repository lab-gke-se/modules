# Only create nodepools if autopilot is not true
resource "google_container_node_pool" "node_pool" {
  for_each = !coalesce(try(var.autopilot.enabled, null), false) && try(var.nodePools, null) != null ? { for nodePool in var.nodePools : nodePool.name => nodePool } : {}

  # Terraform / cluster values
  project  = var.project
  cluster  = google_container_cluster.cluster.id
  location = var.location
  # name_prefix = var.name_prefix

  # Node Pool values
  name               = each.value.name
  initial_node_count = each.value.initialNodeCount
  version            = local.min_master_version
  node_locations     = each.value.locations

  # This should be kept synced with node_config in cluster
  dynamic "node_config" {
    for_each = try(each.value.config, null) != null ? [each.value.config] : []

    content {
      boot_disk_kms_key           = try(node_config.value.bootDiskKmsKey, null)
      disk_size_gb                = try(node_config.value.diskSizeGb, null)
      disk_type                   = try(node_config.value.diskType, null)
      image_type                  = try(node_config.value.imageType, null)
      machine_type                = try(node_config.value.machineType, null)
      metadata                    = try(node_config.value.metadata, null)
      oauth_scopes                = try(node_config.value.oauthScopes, null)
      service_account             = try(node_config.value.serviceAccount, null)
      enable_confidential_storage = try(node_config.value.enableConfidentialStorage, null)
      labels                      = try(node_config.value.labels, null)
      resource_labels             = try(node_config.value.resourceLabels, null)
      local_ssd_count             = try(node_config.value.localSsdCount, null)
      min_cpu_platform            = try(node_config.value.minCpuPlatform, null)
      preemptible                 = try(node_config.value.preemptible, null)
      spot                        = try(node_config.value.spot, null)
      tags                        = try(node_config.value.tags, null)
      resource_manager_tags       = try(node_config.value.resourceManagerTags.tags, null)
      node_group                  = try(node_config.value.nodeGroup, null)
      logging_variant             = try(node_config.value.loggingConfig.variantConfig.variant, null)

      # storage_pools = in terraform document but not in terraform...
      # secondaryBootDiskUpdateStrategy = optional(object({}), null) # Oddly TBD

      # advancedMachineFeatures = optional(object({
      #   threadsPerCore             = optional(string, null)
      #   enableNestedVirtualization = optional(bool, null)
      # }), null)

      dynamic "confidential_nodes" {
        for_each = try(node_config.value.confidentialNodes, null) != null ? [node_config.value.confidentialNodes] : []

        content {
          enabled = try(confidential_nodes.value.enabled, null)
        }
      }

      dynamic "containerd_config" {
        for_each = try(node_config.value.containerdConfig, null) != null ? [node_config.value.containerdConfig] : []

        content {
          dynamic "private_registry_access_config" {
            for_each = try(containerd_config.value.privateRegistryAccessConfig, null) != null ? [containerd_config.value.privateRegistryAccessConfig] : []

            content {
              enabled = private_registry_access_config.value.enabled

              dynamic "certificate_authority_domain_config" {
                for_each = try(private_registry_access_config.value.certificateAuthorityDomainConfig, null) != null ? [private_registry_access_config.value.certificateAuthorityDomainConfig] : []

                content {
                  fqdns = certificate_authority_domain_config.value.fqdns
                  gcp_secret_manager_certificate_config {
                    secret_uri = certificate_authority_domain_config.value.gcpSecretManagerCertificateConfig.secretUri
                  }
                }
              }
            }
          }
        }
      }

      dynamic "ephemeral_storage_local_ssd_config" {
        for_each = try(node_config.value.ephemeralStorageLocalSsdConfig, null) != null ? [node_config.value.ephemeralStorageLocalSsdConfig] : []
        content {
          local_ssd_count = try(ephemeral_storage_local_ssd_config.value.localSsdCount, null)
        }
      }

      dynamic "fast_socket" {
        for_each = try(node_config.value.fastSocket, null) != null ? [node_config.value.fastSocket] : []
        content {
          enabled = fast_socket.value.enabled
        }
      }

      dynamic "guest_accelerator" {
        for_each = try(node_config.value.accelerators, null) != null ? node_config.value.accelerators : []

        content {
          type               = try(guest_accelerator.value.acceleratorType, null)
          count              = try(guest_accelerator.value.acceleratorCount, null)
          gpu_partition_size = try(guest_accelerator.value.gpuPartitionSize, null)

          gpu_driver_installation_config {
            gpu_driver_version = try(guest_accelerator.value.gpuDriverVersion, null)
          }
          gpu_sharing_config {
            gpu_sharing_strategy       = guest_accelerator.value.gpuSharingStrategy
            max_shared_clients_per_gpu = guest_accelerator.value.maxSharedClientsPerGpu
          }
        }
      }

      dynamic "gcfs_config" {
        for_each = try(node_config.value.gcfsConfig, null) != null ? [node_config.value.gcfsConfig] : []

        content {
          enabled = try(gcfs_config.value.enabled, null)
        }
      }

      dynamic "gvnic" {
        for_each = try(node_config.value.gvnic, null) != null ? [node_config.value.gvnic] : []

        content {
          enabled = try(gvnic.value.enabled, null)
        }
      }

      # hostMaintenancePolicy = optional(object({
      #   maintenanceInterval = optional(string, null)
      #   opportunisticMaintenanceStrategy = optional(object({
      #     nodeIdleTimeWindow            = optional(string, null)
      #     maintenanceAvailabilityWindow = optional(string, null)
      #     minNodesPerPool               = optional(string, null)
      #   }), null)
      # }), null)

      dynamic "kubelet_config" {
        for_each = try(node_config.value.kubeletConfig, null) != null ? [node_config.value.kubeletConfig] : []

        content {
          cpu_manager_policy   = kubelet_config.value.cpuManagerPolicy
          cpu_cfs_quota        = try(kubelet_config.value.cpuCfsQuota, null)
          cpu_cfs_quota_period = try(kubelet_config.value.cpuCfsQuotaPeriod, null)
          pod_pids_limit       = try(kubelet_config.value.podPidsLimit, null)
          # insecure_kubelet_readonly_port_enabled = kubelet_config.value.insecureKubeletReadonlyPortEnabled 
        }
      }

      dynamic "linux_node_config" {
        for_each = try(node_config.value.linuxNodeConfig, null) != null ? [node_config.value.linuxNodeConfig] : []

        content {
          sysctls     = try(linux_node_config.value.sysctls, null)
          cgroup_mode = try(linux_node_config.value.cgroupMode, null)
          #   hugepages = optional(object({
          #     hugepageSize2m = optional(number, null)
          #     hugepageSize1g = optional(number, null)
        }
      }

      dynamic "local_nvme_ssd_block_config" {
        for_each = try(node_config.value.localNvmeSsdBlockConfig, null) != null ? [node_config.value.localNvmeSsdBlockConfig] : []

        content {
          local_ssd_count = local_nvme_ssd_block_config.value.localSsdCount
        }
      }

      dynamic "reservation_affinity" {
        for_each = try(node_config.value.reservationAffinity, null) != null ? [node_config.value.reservationAffinity] : []

        content {
          consume_reservation_type = reservation_affinity.value.consumeReservationType
          key                      = try(reservation_affinity.value.key, null)
          values                   = try(reservation_affinity.value.values, null)
        }
      }

      # Beta
      # dynamic "sandbox_config" {
      #   for_each = try(node_config.value.sandboxConfig, null) != null ? [node_config.value.sandboxConfig] : []

      #   content {
      #     sandbox_type = sandbox_config.value.type
      #   }
      # }

      dynamic "secondary_boot_disks" {
        for_each = try(node_config.value.secondaryBootDisks, null) != null ? node_config.value.secondaryBootDisks : []

        content {
          disk_image = secondary_boot_disks.value.diskImage
          mode       = try(secondary_boot_disks.value.mode, null)
        }
      }

      dynamic "shielded_instance_config" {
        for_each = try(node_config.value.shieldedInstanceConfig, null) != null ? [node_config.value.shieldedInstanceConfig] : []

        content {
          enable_secure_boot          = try(shielded_instance_config.value.enableSecureBoot, null)
          enable_integrity_monitoring = try(shielded_instance_config.value.enableIntegrityMonitoring, null)
        }
      }

      dynamic "sole_tenant_config" {
        for_each = try(node_config.value.soleTenantConfig, null) != null ? [node_config.value.soleTenantConfig] : []

        content {
          dynamic "node_affinity" {
            for_each = try(sole_tenant_config.value.nodeAffinities, null) != null ? sole_tenant_config.value.nodeAffinities : []

            content {
              key      = node_affinity.value.key
              operator = node_affinity.value.operator
              values   = node_affinity.value.values
            }
          }
        }
      }

      dynamic "taint" {
        for_each = try(node_config.value.taint, null) != null ? node_config.value.taint : []

        content {
          key    = taint.value.key
          value  = taint.value.value
          effect = taint.value.effect
        }
      }

      # dynamic "windows_node_config" {
      #   for_each = try(node_config.value.windowsNodeConfig, null) != null ? [node_config.value.windowsNodeConfig] : []

      #   content {
      # osVersion = optional(string, null)}
      # }

      dynamic "workload_metadata_config" {
        for_each = try(node_config.value.workloadMetadataConfig, null) != null ? [node_config.value.workloadMetadataConfig] : []

        content {
          mode = workload_metadata_config.value.mode
        }
      }
    }
  }

  dynamic "network_config" {
    for_each = try(each.value.networkConfig, null) != null ? [each.value.networkConfig] : []

    content {
      create_pod_range     = try(network_config.value.createPodRange, null)
      enable_private_nodes = try(network_config.value.enablePrivateNodes, null)
      pod_ipv4_cidr_block  = coalesce(try(network_config.value.createPodRange, null), false) ? try(network_config.value.podIpv4CidrBlock, null) : null
      pod_range            = try(network_config.value.podRange, null)

      # Not supported in 5.33
      # dynamic "additional_node_network_configs" {
      #   for_each = try(network_config.value.additionalNodeNetworkConfigs, null) != null ? [network_config.value.additionalNodeNetworkConfigs] : []

      #   content {
      #     network    = try(additional_node_network_configs.value.network, null)
      #     subnetwork = try(additional_node_network_configs.value.subnetwork, null)
      #   }
      # }

      # dynamic "additional_pod_network_configs" {
      #   for_each = try(network_config.value.additionalPodNetworkConfigs, null) != null ? [network_config.value.additionalPodNetworkConfigs] : []

      #   content {
      #     subnetwork          = try(additional_pod_network_configs.value.subnetwork, null)
      #     secondary_pod_range = try(additional_pod_network_configs.value.secondaryPodRange, null)
      #     max_pods_per_node   = try(additional_pod_network_configs.value.maxPodsPerNode.maxPodsPerNode, null)
      #   }
      # }

      dynamic "network_performance_config" {
        for_each = try(network_config.value.networkPerformanceConfig, null) != null ? [network_config.value.networkPerformanceConfig] : []

        content {
          total_egress_bandwidth_tier = try(network_performance_config.value.totalEgressBandwidthTier, null)
          //??          external_ip_egress_bandwidth_tier = try(network_performance_config.value.externalIpEgressBandwidthTier, null)
        }
      }

      dynamic "pod_cidr_overprovision_config" {
        for_each = try(network_config.value.podCidrOverprovisionConfig, null) != null ? [network_config.value.podCidrOverprovisionConfig] : []

        content {
          disabled = try(pod_cidr_overprovision_config.value.disabled, null)
        }

      }
    }
  }

  dynamic "autoscaling" {
    for_each = try(each.value.autoscaling.enabled, false) ? [each.value.autoscaling] : []

    content {
      min_node_count       = try(autoscaling.value.minNodeCount, null)
      max_node_count       = try(autoscaling.value.maxNodeCount, null)
      total_min_node_count = try(autoscaling.value.totalMinNodeCount, null)
      total_max_node_count = try(autoscaling.value.totalMaxNodeCount, null)
      location_policy      = try(autoscaling.value.locationPolicy, null)
      # autoprovisioned      = optional(bool, null)
    }
  }

  dynamic "management" {
    for_each = try(each.value.management, null) != null ? [each.value.management] : []

    content {
      auto_repair  = try(management.value.autoRepair, null)
      auto_upgrade = try(management.value.autoUpgrade, null)
      # Upgrade options?
    }
  }

  max_pods_per_node = try(each.value.maxPodsConstraint.maxPodsPerNode, null)

  dynamic "upgrade_settings" {
    for_each = try(each.value.upgradeSettings, null) != null ? [each.value.upgradeSettings] : []

    content {
      max_surge       = try(upgrade_settings.value.maxSurge, null)
      max_unavailable = try(upgrade_settings.value.maxUnavailable, null)
      strategy        = try(upgrade_settings.value.strategy, null)

      dynamic "blue_green_settings" {
        for_each = try(upgrade_settings.value.blueGreenSettings, null) != null ? [upgrade_settings.value.blueGreenSettings] : []

        content {
          standard_rollout_policy {
            batch_percentage    = try(blue_green_settings.value.standardRolloutPolicy.batchPercentage, null)
            batch_node_count    = try(blue_green_settings.value.standardRolloutPolicy.batchNodeCount, null)
            batch_soak_duration = try(blue_green_settings.value.standardRolloutPolicy.batchSoakDuration, null)
          }
          # autoscaledRolloutPolicy = optional(object({}), null)
          node_pool_soak_duration = try(upgrade_settings.value.nodePoolSoakDuration, null)
        }
      }
    }
  }

  dynamic "placement_policy" {
    for_each = try(each.value.placementPolicy.type, null) != null ? [each.value.placementPolicy] : []

    content {
      type         = placement_policy.value.type
      tpu_topology = try(placement_policy.value.tpuTopology, null)
      policy_name  = try(placement_policy.value.policyName, null)
    }
  }

  dynamic "queued_provisioning" {
    for_each = try(each.value.queuedProvisioning, null) != null ? [each.value.queuedProvisioning] : []

    content {
      enabled = try(queued_provisioning.value.enabled, null)
    }
  }

  # dynamic "best_effort_provisioning" {
  #   for_each = try(var.bestEffortProvisioning, null) != null ? [var.bestEffortProvisioning] : []

  #   content {}
  # }

  depends_on = [google_container_cluster.cluster]
}

# resource "null_resource" "delete_default_node_pool" {
#   #   count = var.remove_default_node_pool && contains([for np in google_container_cluster.cluster.node_pool : np.name], "default-pool") ? 1 : 0

#   depends_on = [google_container_node_pool.node_pool, google_container_cluster.cluster]

#   provisioner "local-exec" {
#     command = "gcloud container node-pools delete default-pool --cluster ${google_container_cluster.cluster.name} --region ${var.location} --quiet"
#   }
# }
