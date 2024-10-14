# Terraform Variables
variable "project" {
  description = "The project to create the nodepools for."
  type        = string
}

variable "cluster" {
  description = "The cluster to create the nodepool for."
  type        = string
}

variable "location" {
  description = "The location (region or zone) of the cluster"
  type        = string
  default     = null
}

variable "nodePools" {
  description = "The nodepools to create"
  type = list(object({
    name = string
    config = optional(object({
      machineType    = optional(string, null)
      diskSizeGb     = optional(number, null)
      oauthScopes    = optional(list(string), null)
      serviceAccount = optional(string)
      metadata       = optional(map(string))
      imageType      = optional(string, null)
      labels         = optional(map(string), null)
      localSsdCount  = optional(number, null)
      tags           = optional(list(string), null)
      preemptible    = optional(bool, null)
      accelerators = optional(list(object({
        acceleratorCount = optional(string, null)
        acceleratorType  = optional(string, null)
        gpuPartitionSize = optional(string, null)
        gpuSharingConfig = optional(object({
          maxSharedClientsPerGpu = optional(string, null)
          gpuSharingStrategy     = optional(string, null)
        }), null)
        gpuDriverInstallationConfig = optional(object({
          gpuDriverVersion = optional(string, null)
        }), null)
      })), null)
      diskType       = optional(string, null)
      minCpuPlatform = optional(string, null)
      workloadMetadataConfig = optional(object({
        mode = optional(string, null)
      }), null)
      taints = optional(list(object({
        key    = optional(string, null)
        value  = optional(string, null)
        effect = optional(string, null)
      })), null)
      sandboxConfig = optional(object({
        type = optional(string, null)
      }), null)
      nodeGroup = optional(string, null)
      reservationAffinity = optional(object({
        consumeReservationType = optional(string, null)
        key                    = optional(string, null)
        values                 = optional(list(string), null)
      }), null)
      shieldedInstanceConfig = optional(object({
        enableSecureBoot          = optional(bool, null)
        enableIntegrityMonitoring = optional(bool, null)
      }), null)
      linuxNodeConfig = optional(object({
        sysctls    = optional(map(string), null)
        cgroupMode = optional(string, null)
        hugepages = optional(object({
          hugepageSize2m = optional(number, null)
          hugepageSize1g = optional(number, null)
        }), null)
      }), null)
      kubeletConfig = optional(object({
        cpuManagerPolicy                   = optional(string, null)
        cpuCfsQuota                        = optional(bool, null)
        cpuCfsQuotaPeriod                  = optional(string, null)
        podPidsLimit                       = optional(string, null)
        insecureKubeletReadonlyPortEnabled = optional(bool, null)
      }), null)
      bootDiskKmsKey = optional(string, null)
      gcfsConfig = optional(object({
        enabled = optional(bool, null)
      }), null)
      advancedMachineFeatures = optional(object({
        threadsPerCore             = optional(string, null)
        enableNestedVirtualization = optional(bool, null)
      }), null)
      gvnic = optional(object({
        enabled = optional(bool, null)
      }), null)
      spot = optional(bool, null)
      confidentialNodes = optional(object({
        enabled = optional(bool, null)
      }), null)
      resourceLabels = optional(map(string), null)
      loggingConfig = optional(object({
        variantConfig = optional(object({
          variant = optional(string, null)
        }), null)
      }), null)
      windowsNodeConfig = optional(object({
        osVersion = optional(string, null)
      }), null)
      localNvmeSsdBlockConfig = optional(object({
        localSsdCount = optional(number, null)
      }), null)
      ephemeralStorageLocalSsdConfig = optional(object({
        localSsdCount = optional(number, null)
      }), null)
      soleTenantConfig = optional(object({
        nodeAffinities = optional(list(object({
          key      = optional(string, null)
          operator = optional(string, null)
          values   = optional(list(string), null)
        })), null)
      }), null)
      containerdConfig = optional(object({
        privateRegistryAccessConfig = optional(object({
          enabled = optional(bool, null)
          certificateAuthorityDomainConfig = optional(list(object({
            fqdns = optional(list(string), null)
            gcpSecretManagerCertificateConfig = optional(object({
              secretUri = optional(string, null)
            }), null)
          })), null)
        }), null)
      }), null)
      hostMaintenancePolicy = optional(object({
        maintenanceInterval = optional(string, null)
        opportunisticMaintenanceStrategy = optional(object({
          nodeIdleTimeWindow            = optional(string, null)
          maintenanceAvailabilityWindow = optional(string, null)
          minNodesPerPool               = optional(string, null)
        }), null)
      }), null)
      resourceManagerTags = optional(object({
        tags = optional(map(string), null)
      }), null)
      enableConfidentialStorage = optional(bool, null)
      secondaryBootDisks = optional(list(object({
        mode      = optional(string, null)
        diskImage = optional(string, null)
      })), null)
      fastSocket = optional(object({
        enabled = optional(bool, null)
      }), null)
      secondaryBootDiskUpdateStrategy = optional(object({}), null) # Oddly TBD
    }), null)
    initialNodeCount = optional(number, null)
    locations        = optional(list(string), null)
    networkConfig = optional(object({
      createPodRange   = optional(bool, null)
      podRange         = optional(string, null)
      podIpv4CidrBlock = optional(string, null)
      podCidrOverprovisionConfig = optional(object({
        disabled = optional(bool, null)
      }), null)
      additionalNodeNetworkConfigs = optional(list(object({
        network    = optional(string, null)
        subnetwork = optional(string, null)
      })), null)
      additionalPodNetworkConfigs = optional(list(object({
        subnetwork        = optional(string, null)
        secondaryPodRange = optional(string, null)
        maxPodsPerNode = optional(object({
          maxPodsPerNode = optional(string, null)
        }), null)
      })), null)
      podIpv4RangeUtilization = optional(number, null)
      enablePrivateNodes      = optional(bool, null)
      networkPerformanceConfig = optional(object({
        totalEgressBandwidthTier      = optional(string, null)
        externalIpEgressBandwidthTier = optional(string, null)
      }), null)
    }), null)
    nodeVersion = optional(string, null)
    autoscaling = optional(object({
      enabled           = optional(bool, null)
      minNodeCount      = optional(number, null)
      maxNodeCount      = optional(number, null)
      autoprovisioned   = optional(bool, null)
      locationPolicy    = optional(string, null)
      totalMinNodeCount = optional(number, null)
      totalMaxNodeCount = optional(number, null)
    }), null)
    management = optional(object({
      autoUpgrade = optional(bool, null)
      autoRepair  = optional(bool, null)
      upgradeOptions = optional(object({
        autoUpgradeStartTime = optional(string, null)
        description          = optional(string, null)
      }))
    }), null)
    maxPodsConstraint = optional(object({
      maxPodsPerNode = optional(string, null)
    }), null)
    upgradeSettings = optional(object({
      maxSurge       = optional(number, null)
      maxUnavailable = optional(number, null)
      strategy       = optional(string, null)
      blueGreenSettings = optional(object({
        standardRolloutPolicy = optional(object({
          batchPercentage   = optional(number, null)
          batchNodeCount    = optional(number, null)
          batchSoakDuration = optional(string, null)
        }), null)
        autoscaledRolloutPolicy = optional(object({}), null)
        nodePoolSoakDuration    = optional(string, null)
      }), null)
    }), null)
    placementPolicy = optional(object({
      type        = optional(string, null)
      tpuTopology = optional(string, null)
      policyName  = optional(string, null)
    }), null)
    queuedProvisioning = optional(object({
      enabled = optional(bool, null)
    }), null)
  }))
}
