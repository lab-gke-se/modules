resource "google_container_cluster" "primary" {
  provider = google

  project                  = var.project
  deletion_protection      = var.deletion_protection
  remove_default_node_pool = coalesce(try(var.autopilot.enabled, null), false) ? null : var.remove_default_node_pool

  dynamic "addons_config" {
    for_each = try(var.addonsConfig, null) != null ? [var.addonsConfig] : []

    content {
      dynamic "http_load_balancing" {
        for_each = try(addons_config.value.httpLoadBalancing.disabled, null) != null ? [addons_config.value.httpLoadBalancing] : []

        content {
          disabled = try(http_load_balancing.value.disabled, false)
        }
      }
      dynamic "horizontal_pod_autoscaling" {
        for_each = try(addons_config.value.horizontalPodAutoscaling.disabled, null) != null ? [addons_config.value.horizontalPodAutoscaling] : []

        content {
          disabled = try(horizontal_pod_autoscaling.value.disabled, false)
        }
      }
      dynamic "dns_cache_config" {
        for_each = !coalesce(try(var.autopilot.enabled, null), false) && try(addons_config.value.dnsCacheConfig.enabled, null) != null ? [addons_config.value.dnsCacheConfig] : []
        content {
          enabled = try(dns_cache_config.value.enabled, null)
        }
      }
      dynamic "gce_persistent_disk_csi_driver_config" {
        for_each = try(addons_config.value.gcePersistentDiskCsiDriverConfig.enabled, null) != null ? [addons_config.value.gcePersistentDiskCsiDriverConfig] : []
        content {
          enabled = try(gce_persistent_disk_csi_driver_config.value.enabled, null)
        }
      }
      dynamic "gcp_filestore_csi_driver_config" {
        for_each = !coalesce(try(var.autopilot.enabled, null), false) && try(addons_config.value.gcpFilestoreCsiDriverConfig.enabled, null) != null ? [addons_config.value.gcpFilestoreCsiDriverConfig] : []

        content {
          enabled = gcp_filestore_csi_driver_config.value.enabled
        }
      }
      dynamic "gcs_fuse_csi_driver_config" {
        for_each = try(addons_config.value.gcsFuseCsiDriverConfig.enabled, null) != null ? [addons_config.value.gcsFuseCsiDriverConfig] : []
        content {
          enabled = try(gcs_fuse_csi_driver_config.value.enabled, null)
        }
      }
      dynamic "network_policy_config" {
        for_each = !coalesce(try(var.autopilot.enabled, null), false) && try(addons_config.value.networkPolicyConfig.disabled, null) != null ? [addons_config.value.networkPolicyConfig] : []
        content {
          disabled = try(network_policy_config.value.disabled, null)
        }
      }
      dynamic "stateful_ha_config" {
        for_each = !coalesce(try(var.autopilot.enabled, null), false) && try(addons_config.value.statefulHaConfig.enabled, null) != null ? [addons_config.value.statefulHaConfig] : []

        content {
          enabled = try(stateful_ha_config.value.enabled, null)
        }
      }
      dynamic "cloudrun_config" {
        for_each = try(addons_config.value.cloudrunConfig.disabled, null) != null ? [addons_config.value.cloudrunConfig] : []

        content {
          disabled           = try(cloudrun_config.value.disabled, null)
          load_balancer_type = try(cloudrun_config.value.loadBalancerType, null)
        }
      }
      # Beta
      # istio_config {
      #   disabled = try(addons_config.value.istioConfig.disabled, null)
      #   auth     = try(addons_config.value.auth, null)
      # }
      dynamic "gke_backup_agent_config" {
        for_each = try(addons_config.value.gkeBackupAgentConfig.enabled, null) != null ? [addons_config.value.gkeBackupAgentConfig] : []

        content {
          enabled = try(gke_backup_agent_config.value.enabled, null)
        }
      }
      # Beta
      # dynamic "kalm_config" {
      #   for_each = try(addons_config.value.kalm_config.enabled, null) != null ? [addons_config.value.kalm_config] : []

      #   content {
      #     enabled = try(kalm_config.value.enabled, null)
      #   }
      # }
      dynamic "config_connector_config" {
        for_each = try(addons_config.value.configConnectorConfig.enabled, null) != null ? [addons_config.value.configConnectorConfig] : []
        content {
          enabled = try(config_connector_config.value.enabled, null)
        }
      }

      dynamic "ray_operator_config" {
        for_each = try(addons_config.value.rayOperatorConfig.enabled, null) != null ? [addons_config.value.rayOperatorConfig] : []

        content {
          enabled = try(addons_config.value.rayOperatorConfig.enabled, null)
          ray_cluster_logging_config {
            enabled = try(addons_config.value.rayClusterConfig.rayClusterLoggingConfig.enabled, null)
          }
          ray_cluster_monitoring_config {
            enabled = try(addons_config.value.rayOperatorConfig.rayClusterMonitoringConfig.enabled, null)
          }
        }
      }
    }
  }

  dynamic "authenticator_groups_config" {
    for_each = try(var.authenticatorGroupsConfig, null) != null ? [var.authenticatorGroupsConfig] : []

    content {
      security_group = authenticator_groups_config.value.cluster_authenticator_security_group
    }
  }

  enable_autopilot = try(var.autopilot.enabled, null)
  allow_net_admin  = try(var.autopilot.workloadPolicyConfig.allow_net_admin, null)

  dynamic "cluster_autoscaling" {
    for_each = try(var.autoscaling, null) != null ? [var.autoscaling] : []

    content {
      enabled                     = try(cluster_autoscaling.value.enableNodeAutoProvisioning, null)
      auto_provisioning_locations = cluster_autoscaling.value.autoprovisioningLocations
      autoscaling_profile         = try(cluster_autoscaling.value.autoscalingProfile, null)

      dynamic "auto_provisioning_defaults" {
        for_each = try(cluster_autoscaling.value.autoprovisioningNodePoolDefaults, null) != null ? [cluster_autoscaling.value.autoprovisioningNodePoolDefaults] : []

        content {
          boot_disk_kms_key = try(auto_provisioning_defaults.value.bootDiskKmsKey, null)
          disk_size         = try(auto_provisioning_defaults.value.diskSize, null)
          disk_type         = try(auto_provisioning_defaults.value.diskType, null)
          image_type        = try(auto_provisioning_defaults.value.imageType, null)
          min_cpu_platform  = try(auto_provisioning_defaults.value.minCpuPlatform, null)
          oauth_scopes      = try(auto_provisioning_defaults.value.oauthScopes, null)
          service_account   = try(auto_provisioning_defaults.value.serviceAccount, null)
          # ?? insecure_kubelet_readonly_port_enabled = try(auto_provisioning_defaults.value.insecureKubeletReadonlyPortEnabled, null)

          dynamic "management" {
            for_each = try(auto_provisioning_defaults.value.management, null) != null ? [auto_provisioning_defaults.value.management] : []

            content {
              auto_repair  = try(management.value.autoRepair, null)
              auto_upgrade = try(management.value.autoUpgrade, null)
              dynamic "upgrade_options" {
                for_each = try(management.value.upgradeOptions, null) != null ? [management.value.upgradeOptions] : []

                content {
                  auto_upgrade_start_time = try(upgrade_options.value.autoUpgradeStartTime, null)
                  description             = try(upgrade_options.value.description, null)
                }
              }
            }
          }

          dynamic "shielded_instance_config" {
            for_each = try(auto_provisioning_defaults.value.shieldedInstanceConfig, null) != null ? [auto_provisioning_defaults.value.shieldedInstanceConfig] : []

            content {
              enable_secure_boot          = try(shielded_instance_config.value.enableSecureBoot, null)
              enable_integrity_monitoring = try(shielded_instance_config.value.enableIntegrityMonitoring, null)
            }
          }

          dynamic "upgrade_settings" {
            for_each = try(auto_provisioning_defaults.values.upgradeSettings, null) != null ? [auto_provisioning_defaults.values.upgradeSettings] : []

            content {
              strategy        = try(upgrade_settings.value.strategy, null)
              max_surge       = try(upgrade_settings.value.maxSurge, null)
              max_unavailable = try(upgrade_settings.value.maxUnavailable, null)

              dynamic "blue_green_settings" {
                for_each = try(upgrade_settings.values.blueGreenSettings, null) != null ? [upgrade_settings.values.blueGreenSettings] : []

                content {
                  node_pool_soak_duration = try(blue_green_settings.value.nodePoolSoakDuration, null)

                  dynamic "standard_rollout_policy" {
                    for_each = try(blue_green_settings.values.standardRolloutPolicy, null) != null ? [blue_green_settings.values.blueGreenSettstandardRolloutPolicyings] : []

                    content {
                      batch_percentage    = try(standard_rollout_policy.value.batchPercentate, null)
                      batch_node_count    = try(standard_rollout_policy.value.batchNodeCount, null)
                      batch_soak_duration = try(standard_rollout_policy.value.batchSoakDuration, null)
                    }
                  }
                }
              }
            }
          }
        }
      }
      dynamic "resource_limits" {
        for_each = !coalesce(try(var.autopilot.enabled, null), false) && try(cluster_autoscaling.value.resourceLimits, null) != null ? cluster_autoscaling.value.resourceLimits : []

        content {
          resource_type = try(resource_limits.value.resourceType, null)
          minimum       = try(resource_limits.value.minimum, null)
          maximum       = try(resource_limits.value.maximum, null)
        }
      }
    }
  }

  dynamic "binary_authorization" {
    for_each = try(var.binaryAuthorization, null) != null ? [var.binaryAuthorization] : []

    content {
      evaluation_mode = try(binary_authorization.value.evaluationMode, null)
    }
  }

  cluster_ipv4_cidr = try(var.ipAllocationPolicy, null) == null ? try(var.clusterIpv4Cidr, null) : null

  dynamic "confidential_nodes" {
    for_each = try(var.confidentialNodes, null) != null ? [var.confidentialNodes] : []

    content {
      enabled = try(confidential_nodes.value.enabled, null)
    }
  }

  dynamic "cost_management_config" {
    for_each = try(var.costManagementConfig, null) != null ? [var.costManagementConfig] : []

    content {
      enabled = cost_management_config.value.enabled
    }
  }

  dynamic "database_encryption" {
    for_each = try(var.databaseEncryption, null) != null ? [var.databaseEncryption] : []

    content {
      state    = try(database_encryption.value.state, null)
      key_name = try(database_encryption.value.keyName, null)
    }
  }

  default_max_pods_per_node = try(to_number(var.defaultMaxPodsConstraint), null)
  description               = try(var.description, null)
  enable_kubernetes_alpha   = try(var.enableKubernetesAlpha, null)

  dynamic "enable_k8s_beta_apis" {
    for_each = try(var.enableK8sBetaApis, null) != null ? [var.enableK8sBetaApis] : []

    content {
      enabled_apis = enable_k8s_beta_apis.value.enabledApis
    }
  }

  enable_tpu = try(var.enableTpu, null)

  dynamic "fleet" {
    for_each = try(var.fleet, null) != null ? [var.fleet] : []

    content {
      project = try(fleet.value.project, null)
      # membership     = try(fleet.value.membership, null)
      pre_registered = try(fleet.value.perRegistered, null)
    }
  }

  dynamic "identity_service_config" {
    for_each = try(var.identityServiceConfig, null) != null ? [var.identityServiceConfig] : []
    content {
      enabled = try(identity_service_config.value.enabled)
    }
  }

  initial_node_count = var.initialNodeCount

  dynamic "ip_allocation_policy" {
    for_each = try(var.ipAllocationPolicy, null) != null ? [var.ipAllocationPolicy] : []

    content {
      cluster_secondary_range_name  = try(ip_allocation_policy.value.clusterSecondaryRangeName, null)
      services_secondary_range_name = try(ip_allocation_policy.value.servicesSecondaryRangeName, null)
      cluster_ipv4_cidr_block       = try(ip_allocation_policy.value.clusterSecondaryRangeName, null) == null ? try(ip_allocation_policy.value.clusterIpv4CidrBlock, null) : null
      services_ipv4_cidr_block      = try(ip_allocation_policy.value.servicesSecondaryRangeName, null) == null ? try(ip_allocation_policy.value.servicesIpv4CidrBlock, null) : null
      stack_type                    = try(ip_allocation_policy.value.stackType, null)

      dynamic "additional_pod_ranges_config" {
        for_each = try(ip_allocation_policy.value.additionalPodRangesConfig, null) != null ? [ip_allocation_policy.value.additionalPodRangesConfig] : []
        content {
          pod_range_names = additional_pod_ranges_config.value.podRangeNames
          #       podRangeInfo = optional(list(object({
          #         rangeName   = optional(string, null)
          #         utilization = optional(number, null)
          #       })), null)
        }
      }

      # Not supported by terraform ?
      #     useIpAliases               = optional(bool, null)
      #     createSubnetwork           = optional(bool, null)
      #     subnetworkName             = optional(string, null)
      #     clusterIpv4Cidr            = optional(string, null)
      #     nodeIpv4Cidr               = optional(string, null)
      #     servicesIpv4Cidr           = optional(string, null)
      #     servicesIpv4CidrBlock      = optional(string, null)
      #     tpuIpv4CidrBlock           = optional(string, null)
      #     useRoutes                  = optional(bool, null)
      #     ipv6AccessType             = optional(string, null)
      #     podCidrOverprovisionConfig = optional(object({
      #       disable = optional(bool, null)
      #     }), null)
      #     subnetIpv6CidrBlock   = optional(string, null)
      #     servicesIpv6CidrBlock = optional(string, null)
      #     defaultPodIpv4RangeUtilization = optional(number, null)
    }
  }

  enable_legacy_abac = try(var.legacyAbac.enabled, null)
  location           = try(var.location, null)
  node_locations     = try(var.locations, null)

  dynamic "logging_config" {
    for_each = try(var.loggingConfig, null) != null ? [var.loggingConfig] : []

    content {
      enable_components = try(logging_config.value.componentConfig.enableComponents, null)
    }
  }

  logging_service = try(var.loggingService, null)

  dynamic "maintenance_policy" {
    for_each = try(var.maintenancePolicy, null) != null ? [var.maintenancePolicy] : []

    content {
      dynamic "recurring_window" {
        for_each = try(maintenance_policy.value.window.recurringWindow, null) != null ? [maintenance_policy.value.window.recurringWindow] : []

        content {
          start_time = recurring_window.value.window.startTime
          end_time   = recurring_window.value.window.endTime
          recurrence = recurring_window.value.recurrence
        }
      }

      dynamic "daily_maintenance_window" {
        for_each = try(maintenance_policy.value.window.dailyMaintenanceWindow, null) != null ? [maintenance_policy.value.window.dailyMaintenanceWindow] : []

        content {
          start_time = daily_maintenance_window.value.startTime
        }
      }

      dynamic "maintenance_exclusion" {
        for_each = try(maintenance_policy.value.window.maintenanceExclusions, null) != null ? maintenance_policy.value.window.maintenanceExclusions : {}

        content {
          exclusion_name = maintenance_exclusion.key
          start_time     = maintenance_exclusion.value.startTime
          end_time       = maintenance_exclusion.value.endTime

          dynamic "exclusion_options" {
            for_each = try(maintenance_exclusion.value.maintenanceExclusionOptions, null) != null ? [maintenance_exclusion.value.maintenanceExclusionOptions] : []
            content {
              scope = exclusion_options.value.scope
            }
          }
        }
      }
    }
  }

  dynamic "master_auth" {
    for_each = try(var.masterAuth.clientCertificateConfig.issueClientCertificate, null) != null ? [var.masterAuth] : []

    content {
      client_certificate_config {
        issue_client_certificate = master_auth.value.clientCertificateConfig.issueClientCertificate
      }
    }
  }

  dynamic "master_authorized_networks_config" {
    for_each = try(var.masterAuthorizedNetworksConfig, null) != null ? [var.masterAuthorizedNetworksConfig] : []
    content {
      dynamic "cidr_blocks" {
        for_each = master_authorized_networks_config.value.cidrBlocks
        content {
          cidr_block   = try(cidr_blocks.value.cidrBlock, null)
          display_name = try(cidr_blocks.value.displayName, null)
        }
      }
      gcp_public_cidrs_access_enabled = master_authorized_networks_config.value.gcpPublicCidrsAccessEnabled
    }
  }

  dynamic "mesh_certificates" {
    for_each = try(var.meshCertificates, null) != null ? [var.meshCertificates] : []

    content {
      enable_certificates = mesh_certificates.value.enableCertificates
    }
  }

  min_master_version = local.min_master_version

  dynamic "monitoring_config" {
    for_each = try(var.monitoringConfig, null) != null ? [var.monitoringConfig] : []

    content {
      enable_components = try(monitoring_config.value.componentConfig.enableComponents, null)

      dynamic "managed_prometheus" {
        for_each = try(monitoring_config.value.managedPrometheus, null) != null ? [monitoring_config.value.managedPrometheus] : []

        content {
          enabled = try(monitoring_config.value.managedPrometheusConfig.enabled, null)
        }
      }
      dynamic "advanced_datapath_observability_config" {
        for_each = try(monitoring_config.value.advancedDatapathObservabilityConfig.enableMetrics, null) != null ? [monitoring_config.value.advancedDatapathObservabilityConfig] : []

        content {
          enable_metrics = advanced_datapath_observability_config.value.enableMetrics
          enable_relay   = advanced_datapath_observability_config.value.enableRelay
          # relay_mode = optional(string, null)
        }
      }
    }
  }

  monitoring_service = try(var.monitoringService, null)

  name            = var.name
  network         = try(var.network, null)
  networking_mode = "VPC_NATIVE"

  # var.networkConfig
  dynamic "default_snat_status" {
    for_each = try(var.networkConfig.defaultSnatStatus.disabled, null) != null ? [var.networkConfig.defaultSnatStatus] : []

    content {
      disabled = try(default_snat_status.value.disabled, false)
    }
  }

  dynamic "dns_config" {
    for_each = try(var.networkConfig.dnsConfig, null) != null ? [var.networkConfig.dnsConfig] : []

    content {
      cluster_dns        = try(dns_config.value.clusterDns, null)
      cluster_dns_domain = try(dns_config.value.clusterDnsDomain, null)
      cluster_dns_scope  = try(dns_config.value.clusterDnsScope, null)
      # additive_vpc_scope_dns_domain = try(dns_config.value.additiveVpcScopeDnsDomain, null) ??
    }
  }

  enable_l4_ilb_subsetting                 = try(var.networkConfig.enableL4ilbSubsetting, null)
  private_ipv6_google_access               = try(var.networkConfig.privateIpv6GoogleAccess, null)
  datapath_provider                        = try(var.networkConfig.datapathProvider, null)
  enable_intranode_visibility              = !coalesce(try(var.autopilot.enabled, null), false) ? try(var.networkConfig.enableIntraNodeVisibility, null) : null
  enable_multi_networking                  = try(var.networkConfig.enableMultiNetworking, null)
  enable_cilium_clusterwide_network_policy = try(var.networkConfig.enableCiliumClusterwideNetworkPolicy, null)
  # enable_fqdn_network_policy = enableFqdnNetworkPolicy - beta
  # networkPerformanceConfig = optional(object({
  #   totalEgressBandwidthTier = optional(string, null)
  # }), null)  #     
  # inTransitEncryptionConfig            = optional(string, null)

  dynamic "gateway_api_config" {
    for_each = try(var.networkConfig.gatewayApiConfig, null) != null ? [var.networkConfig.gatewayApiConfig] : []

    content {
      channel = try(gateway_api_config.value.channel, null)
    }
  }

  dynamic "service_external_ips_config" {
    for_each = try(var.networkConfig.serviceExternalIpsConfig.enabled, null) != null ? [var.networkConfig.serviceExternalIpsConfig] : []

    content {
      enabled = try(service_external_ips_config.value.enabled, false)
    }
  }
  # end - var.networkConfig

  dynamic "network_policy" {
    for_each = try(var.networkPolicy, null) != null ? [var.networkPolicy] : []

    content {
      enabled  = network_policy.value.enabled
      provider = try(network_policy.value.provider, null)
    }
  }

  # This should be kept synced with config in node_pool
  # According to the documentation, autopilot clusters ignore these settings... 
  dynamic "node_config" {
    for_each = try(var.nodeConfig, null) != null ? [var.nodeConfig] : []

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

  # variable "nodeIpv4CidrSize" {
  #   description = ""
  #   type        = number
  #   default     = null
  # }

  dynamic "node_pool_auto_config" {
    for_each = try(var.nodePoolAutoConfig, null) != null ? [var.nodePoolAutoConfig] : []

    content {
      dynamic "network_tags" {
        for_each = try(node_pool_auto_config.value.networkTags, null) != null ? [node_pool_auto_config.value.networkTags] : []

        content {
          tags = try(network_tags.value.tags, null)
        }
      }
      resource_manager_tags = try(node_pool_auto_config.value.resourceManagerTags.tags, null)

      # dynamic "node_kubelet_config" { ??
      #   for_each = try(node_pool_auto_config.value.nodeKubletConfig, null) != null ? [node_pool_auto_config.value.nodeKubletConfig] : []

      #   content {
      #     insecure_kubelet_readonly_port_enabled = try(node_kubelet.value.insecureKubeletReadonlyPortEnabled, null)
      #     # cpu_manager_policy = try(node_kubelet_config.cpuManagerPolicy, null)
      #     # cpuCfsQuota                        = optional(bool, null)
      #     # cpuCfsQuotaPeriod                  = optional(string, null)
      #     # podPidsLimit                       = optional(string, null)
      #   }
      # }
    }
  }

  dynamic "node_pool_defaults" {
    for_each = try(var.nodePoolDefaults, null) != null ? [var.nodePoolDefaults] : []

    content {
      dynamic "node_config_defaults" {
        for_each = try(node_pool_defaults.value.nodeConfigDefaults, null) != null ? [node_pool_defaults.value.nodeConfigDefaults] : []

        content {
          logging_variant = try(node_pool_defaults.value.nodeConfigDefaults.loggingConfig.variantConfig.variant, null)
          # insecure_kubelet_readonly_port_enabled = try(node_pool_defaults.value.insecureKubeletReadonlyPortEnabled, null)

          dynamic "containerd_config" {
            for_each = try(node_config_defaults.value.containerdConfig, null) != null ? [node_config_defaults.value.containerdConfig] : []

            content {
              dynamic "private_registry_access_config" {
                for_each = try(containerd_config.value.privateRegistryAccessConfig, null) != null ? [containerd_config.value.privateRegistryAccessConfig] : []

                content {
                  enabled = try(private_registry_access_config.value.enabled, true)

                  dynamic "certificate_authority_domain_config" {
                    for_each = try(private_registry_access_config.value.certificateAuthorityDomainConfig, null) != null ? private_registry_access_config.value.certificateAuthorityDomainConfig : []

                    content {
                      fqdns = try(certificate_authority_domain_config.value.fqdns, null)
                      gcp_secret_manager_certificate_config {
                        secret_uri = try(certificate_authority_domain_config.value.gcpSecretManagerCertificateConfig.secretUri, null)
                      }
                    }
                  }
                }
              }
            }
          }

          # dynamic "gcfs_config" {
          #   for_each = try(node_config_defaults.value.gcfsConfig.enabled, null) != null ? [node_config_defaults.value.gcfsConfig] : []

          #   content {
          #     enabled = try(node_config_defaults.value.gcfsConfig.enabled, null)
          #   }
          # }

          #       nodeKubeletConfig = optional(object({
          #         cpuManagerPolicy                   = optional(string, null)
          #         cpuCfsQuota                        = optional(bool, null)
          #         cpuCfsQuotaPeriod                  = optional(string, null)
          #         podPidsLimit                       = optional(string, null)
          #         insecureKubeletReadonlyPortEnabled = optional(bool, null)
          #       }), null)
          #     }), null)
        }
      }
    }
  }

  dynamic "notification_config" {
    for_each = try(var.notificationConfig, null) != null ? [var.notificationConfig] : []

    content {
      pubsub {
        enabled = try(notification_config.value.topic, null) != null ? true : false
        topic   = try(notification_config.value.topic, null)

        dynamic "filter" {
          for_each = try(notification_config.value.filter, null) != null ? [notification_config.value.filter] : []

          content {
            event_type = try(notification_config.value.eventType, null)
          }
        }
      }
    }
  }

  dynamic "private_cluster_config" {
    for_each = try(var.privateClusterConfig, null) != null ? [var.privateClusterConfig] : []

    content {
      enable_private_endpoint     = try(private_cluster_config.value.enablePrivateEndpoint, false)
      enable_private_nodes        = try(private_cluster_config.value.enablePrivateNodes, false)
      master_ipv4_cidr_block      = try(private_cluster_config.value.masterIpv4CidrBlock, null)
      private_endpoint_subnetwork = try(private_cluster_config.value.privateEndpointSubnetwork, null)
      #     peeringName               = optional(string, null) - read only
      #     privateEndpoint           = optional(string, null) - read only
      #     publicEndpoint            = optional(string, null) - read only

      dynamic "master_global_access_config" {
        for_each = try(private_cluster_config.value.masterGlobalAccessConfig, null) != null ? [private_cluster_config.value.masterGlobalAccessConfig] : []

        content {
          enabled = try(private_cluster_config.value.masterGlobalAccessConfig.enabled, false)
        }
      }
    }
  }

  dynamic "release_channel" {
    for_each = try(var.releaseChannel, null) != null ? [var.releaseChannel] : []

    content {
      channel = try(release_channel.value.channel, null)
    }
  }

  resource_labels = try(var.resourceLabels, null)

  dynamic "resource_usage_export_config" {
    for_each = try(var.resourceUsageExportConfig, null) != null ? [var.resourceUsageExportConfig] : []

    content {
      enable_resource_consumption_metering = try(resource_usage_export_config.value.consumptionMeteringConfig.enabled, null)
      enable_network_egress_metering       = try(resource_usage_export_config.value.enableNetworkEgressMetering, null)

      bigquery_destination {
        dataset_id = bigquery_destination.value.datasetId
      }
    }

  }

  dynamic "security_posture_config" {
    for_each = try(var.securityPostureConfig, null) != null ? [var.securityPostureConfig] : []

    content {
      mode               = try(security_posture_config.value.mode, null)
      vulnerability_mode = try(security_posture_config.value.vulnerabilityMode, null)
    }
  }

  enable_shielded_nodes = !coalesce(try(var.autopilot.enabled, null), false) ? try(var.shieldedNodes.enabled, null) : null
  # services_ipv4_cidr    = try(var.servicesIpv4Cidr, null) output only
  # tpu_ipv4_cidr_block   = try(var.tpuIpv4CidrBlock, null) output only
  subnetwork = try(var.subnetwork)

  dynamic "vertical_pod_autoscaling" {
    for_each = try(var.verticalPodAutoscaling.enabled, null) != null ? [var.verticalPodAutoscaling] : []

    content {
      enabled = try(vertical_pod_autoscaling.value.enabled, null)
    }
  }

  dynamic "workload_identity_config" {
    for_each = try(var.workloadIdentityConfig, null) != null ? [var.workloadIdentityConfig] : []

    content {
      workload_pool = try(workload_identity_config.value.workloadPool, null)
    }
  }

  timeouts {
    create = try(var.timeouts.create, "45m")
    update = try(var.timeouts.update, "45m")
    delete = try(var.timeouts.delete, "45m")
  }
}
