resource "google_container_cluster" "primary" {
  provider = google-beta

  name                = var.name
  description         = var.description
  project             = var.project
  deletion_protection = var.deletion_protection

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
        for_each = !try(var.autopilot.enabled, false) && try(addons_config.value.dnsCacheConfig, null) != null ? [addons_config.value.dnsCacheConfig] : []
        content {
          enabled = try(dns_cache_config.value.enabled, null)
        }
      }
      dynamic "gce_persistent_disk_csi_driver_config" {
        for_each = try(addons_config.value.gcePersistentDiskCsiDriverConfig, null) != null ? [addons_config.value.gcePersistentDiskCsiDriverConfig] : []
        content {
          enabled = try(gce_persistent_disk_csi_driver_config.value.enabled, null)
        }
      }
      dynamic "gcp_filestore_csi_driver_config" {
        for_each = !try(var.autopilot.enabled, false) && try(addons_config.value.gcpFilestoreCsiDriverConfig, null) != null ? [addons_config.value.gcpFilestoreCsiDriverConfig] : []

        content {
          enabled = gcp_filestore_csi_driver_config.value.enabled
        }
      }
      dynamic "gcs_fuse_csi_driver_config" {
        for_each = try(addons_config.value.gcsFuseCsiDriverConfig, null) != null ? [addons_config.value.gcsFuseCsiDriverConfig] : []
        content {
          enabled = try(gcs_fuse_csi_driver_config.value.enabled, null)
        }
      }
      dynamic "network_policy_config" {
        for_each = !try(var.autopilot.enabled, false) && try(addons_config.value.networkPolicyConfig, null) != null ? [addons_config.value.networkPolicyConfig] : []
        content {
          disabled = try(network_policy_config.value.disabled, null)
        }
      }
      dynamic "stateful_ha_config" {
        for_each = try(var.autopilot.enabled, false) ? [] : [addons_config.value.statefulHaConfig]

        content {
          enabled = try(stateful_ga_config.value.enabled, null)
        }
      }
      dynamic "cloudrun_config" {
        for_each = try(addons_config.value.cloudrunConfig, null) != null ? [addons_config.value.cloudrunConfig] : []

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
        for_each = try(addons_config.value.gkeBackupAgentConfig, null) != null ? [addons_config.value.gkeBackupAgentConfig] : []

        content {
          enabled = try(gke_backup_agent_config.value.enabled, null)
        }
      }
      # Beta?
      dynamic "kalm_config" {
        for_each = try(addons_config.value.kalm_config, null) != null ? [addons_config.value.kalm_config] : []

        content {
          enabled = try(kalm_config.value.enabled, null)
        }
      }
      dynamic "config_connector_config" {
        for_each = try(addons_config.value.configConnectorConfig, null) != null ? [addons_config.value.configConnectorConfig] : []
        content {
          enabled = try(config_connector_config.value.enabled, null)
        }
      }
      # Updated provider required?
      # ray_operator_config {
      #   enabled                    = try(addons_config.value.rayOperatorConfig.enabled, null)
      #   ray_cluster_logging_config {
      #     enabled = try(addons_config.value.rayClusterConfig.rayClusterLoggingConfig.enabled, null)
      #   }
      #   ray_cluster_monitoring_config {
      #     enabled = try(addons_config.value.rayOperatorConfig.rayClusterMonitoringConfig.enabled, null)
      #   }
      # }
    }
  }

  enable_autopilot = try(var.autopilot.enabled, null)

  dynamic "cluster_autoscaling" {
    for_each = try(var.autoscaling, null) != null ? [var.autoscaling] : []

    content {
      dynamic "auto_provisioning_defaults" {
        for_each = try(cluster_autoscaling.value.autoprovisioningNodePoolDefaults, null) != null ? [cluster_autoscaling.value.autoprovisioningNodePoolDefaults] : []

        content {
          boot_disk_kms_key = try(auto_provisioning_defaults.value.bootDiskKmsKey, null)
          disk_size         = try(auto_provisioning_defaults.value.diskSize, null)
          disk_type         = try(auto_provisioning_defaults.value.diskType, null)
          image_type        = try(auto_provisioning_defaults.value.imageType, null)

          dynamic "management" {
            for_each = try(auto_provisioning_defaults.value.management, null) != null ? [auto_provisioning_defaults.value.management] : []

            content {
              auto_repair  = try(management.value.autoRepair, null)
              auto_upgrade = try(management.value.autoUpgrade, null)
            }
          }

          oauth_scopes    = try(auto_provisioning_defaults.value.oauthScopes, null)
          service_account = try(auto_provisioning_defaults.value.serviceAccount, null)

          dynamic "upgrade_settings" {
            for_each = try(auto_provisioning_defaults.values.upgradeSettings, null) != null ? [auto_provisioning_defaults.values.upgradeSettings] : []

            content {
              max_surge = try(upgrade_settings.value.maxSurge, null)
              strategy  = try(upgrade_settings.value.strategy, null)
            }
          }
        }
      }
      autoscaling_profile = try(cluster_autoscaling.value.autoscalingProfile, null)
      enabled             = try(cluster_autoscaling.value.enableNodeAutoProvisioning, null)
      dynamic "resource_limits" {
        for_each = !try(var.autopilot.enabled, false) && try(cluster_autoscaling.value.resourceLimits, null) != null ? [cluster_autoscaling.value.resourceLimits] : []

        content {
          resource_type = try(resource_limits.value.resourceType, null)
          minimum       = try(resource_limits.value.minimum, null)
          maximum       = try(resource_limits.value.maximum, null)
        }
      }
    }
  }

  # TODO
  # dynamic "binary_authorization" {
  #   for_each = try(var.binaryAuthorization, null) != null ? [var.binaryAuthorization] : []

  #   content {

  #   }
  # }

  cluster_ipv4_cidr = try(var.ipAllocationPolicy, null) == null ? try(var.clusterIpv4Cidr, null) : null

  dynamic "database_encryption" {
    for_each = try(var.databaseEncryption, null) != null ? [var.databaseEncryption] : []

    content {
      state    = try(database_encryption.value.state, null)
      key_name = try(database_encryption.value.keyName, null)
    }
  }

  default_max_pods_per_node = try(to_number(var.defaultMaxPodsConstraint), null)

  dynamic "ip_allocation_policy" {
    for_each = try(var.ipAllocationPolicy, null) != null ? [var.ipAllocationPolicy] : []

    content {
      cluster_ipv4_cidr_block       = try(ip_allocation_policy.value.clusterSecondaryRangeName, null) == null ? try(ip_allocation_policy.value.clusterIpv4CidrBlock, null) : null
      cluster_secondary_range_name  = try(ip_allocation_policy.value.clusterSecondaryRangeName, null)
      services_ipv4_cidr_block      = try(ip_allocation_policy.value.servicesSecondaryRangeName, null) == null ? try(ip_allocation_policy.value.servicesIpv4CidrBlock, null) : null
      services_secondary_range_name = try(ip_allocation_policy.value.servicesSecondaryRangeName, null)
      stack_type                    = try(ip_allocation_policy.value.stackType, null)
      dynamic "additional_pod_ranges_config" {
        for_each = try(ip_allocation_policy.value.additionalPodRangesConfig, null) != null ? [ip_allocation_policy.value.additionalPodRangesConfig] : []
        content {
          pod_range_names = additional_pod_ranges_config.value.podRangeNames
        }
      }
      # use_ip_aliases                = ip_allocation_policy.value.useIpAliases
      # cluster_ipv4_cidr = ip_allocation_policy.value.clusterIpv4Cidr 
      # services_ipv4_cidr = ip_allocation_policy.value.servicesIpv4Cidr 
      # pod_cidr_overprovision_config = ip_allocation_policy.value.podCidrOverprovisionConfig 
    }
  }


  location       = try(var.location, null)
  node_locations = try(var.locations, null)

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

  min_master_version = local.min_master_version

  dynamic "monitoring_config" {
    for_each = try(var.monitoringConfig, null) != null ? [var.monitoringConfig] : []

    content {
      enable_components = try(monitoring_config.value.componentConfig.enableComponents, null)
      managed_prometheus {
        enabled = try(monitoring_config.value.managedPrometheusConfig.enabled, null)
      }
    }
  }

  monitoring_service = try(var.monitoringService, null)

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
    }
  }

  datapath_provider           = try(var.networkConfig.datapathProvider, null)
  enable_intranode_visibility = !try(var.autopilot.enabled, false) ? try(var.networkConfig.enableIntraNodeVisibility, null) : null

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

  dynamic "node_config" {
    # for_each = try(var.nodeConfig, null) != null ? [var.nodeConfig] : []
    for_each = [var.nodeConfig]

    content {
      boot_disk_kms_key = try(node_config.value.bootDiskKmsKey, null)
      disk_size_gb      = try(node_config.value.diskSizeGb, null)
      disk_type         = try(node_config.value.diskType, null)
      image_type        = try(node_config.value.imageType, null)
      machine_type      = try(node_config.value.machineType, null)
      metadata          = try(node_config.value.metadata, null)
      oauth_scopes      = try(node_config.value.oauthScopes, null)

      dynamic "reservation_affinity" {
        for_each = try(node_config.value.reservationAffinity, null) != null ? [node_config.value.reservationAffinity] : []

        content {
          consume_reservation_type = try(reservation_affinity.value.consumeReservationType, null)
        }
      }

      service_account = try(node_config.value.serviceAccount, null)

      dynamic "shielded_instance_config" {
        for_each = try(node_config.value.shieldedInstanceConfig, null) != null ? [node_config.value.shieldedInstanceConfig] : []

        content {
          enable_secure_boot          = try(shielded_instance_config.value.enableSecureBoot, null)
          enable_integrity_monitoring = try(shielded_instance_config.value.enableIntegrityMonitoring, null)
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

      #   content {}
      # }

      dynamic "workload_metadata_config" {
        for_each = try(node_config.value.workloadMetadataConfig, null) != null ? [node_config.value.workloadMetadataConfig] : []

        content {
          mode = workload_metadata_config.value.mode
        }
      }
    }
  }

  dynamic "node_pool_defaults" {
    for_each = try(var.nodePoolDefaults, null) != null ? [var.nodePoolDefaults] : []

    content {
      dynamic "node_config_defaults" {
        for_each = try(node_pool_defaults.value.nodeConfigDefaults, null) != null ? [node_pool_defaults.value.nodeConfigDefaults] : []

        content {
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
                        secret_uri = try(certificate_authority_domain_config.value.gcpSecretManagerCertificateConfig.secretURI)
                      }
                    }
                  }
                }
              }
            }
          }
          logging_variant = try(node_pool_defaults.value.nodeConfigDefaults.loggingConfig.variantConfig.variant, null)
          dynamic "gcfs_config" {
            for_each = try(node_config_defaults.value.gcfsConfig, null) != null ? [node_config_defaults.value.gcfsConfig] : []

            content {
              enabled = try(node_config_defaults.value.gcfsConfig.enabled, null)
            }
          }
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

  dynamic "security_posture_config" {
    for_each = try(var.securityPostureConfig, null) != null ? [var.securityPostureConfig] : []

    content {
      mode               = try(security_posture_config.value.mode, null)
      vulnerability_mode = try(security_posture_config.value.vulnerabilityMode, null)
    }
  }

  enable_shielded_nodes = !try(var.autopilot.enabled, false) ? try(var.shieldedNodes.enabled, null) : null

  subnetwork = try(var.subnetwork)

  dynamic "vertical_pod_autoscaling" {
    for_each = try(var.verticalPodAutoscaling, null) != null ? [var.verticalPodAutoscaling] : []

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

  /*
  enable_fqdn_network_policy = var.enable_fqdn_network_policy

  dynamic "cost_management_config" {
    for_each = var.enable_cost_allocation ? [1] : []
    content {
      enabled = var.enable_cost_allocation
    }
  }

  dynamic "confidential_nodes" {
    for_each = local.confidential_node_config
    content {
      enabled = confidential_nodes.value.enabled
    }
  }


  dynamic "node_pool_auto_config" {
    for_each = length(var.network_tags) > 0 ? [1] : []
    content {
      network_tags {
        tags = var.network_tags
      }
    }
  }


  allow_net_admin = var.allow_net_admin

  protect_config {
    workload_config {
      audit_mode = var.workload_config_audit_mode
    }
    workload_vulnerability_mode = var.workload_vulnerability_mode
  }

  dynamic "fleet" {
    for_each = var.fleet_project != null ? [1] : []
    content {
      project = var.fleet_project
    }
  }

  dynamic "resource_usage_export_config" {
    for_each = var.resource_usage_export_dataset_id != "" ? [{
      enable_network_egress_metering       = var.enable_network_egress_export
      enable_resource_consumption_metering = var.enable_resource_consumption_export
      dataset_id                           = var.resource_usage_export_dataset_id
    }] : []

    content {
      enable_network_egress_metering       = resource_usage_export_config.value.enable_network_egress_metering
      enable_resource_consumption_metering = resource_usage_export_config.value.enable_resource_consumption_metering
      bigquery_destination {
        dataset_id = resource_usage_export_config.value.dataset_id
      }
    }
  }




  dynamic "authenticator_groups_config" {
    for_each = local.cluster_authenticator_security_group
    content {
      security_group = authenticator_groups_config.value.security_group
    }
  }

*/
}
