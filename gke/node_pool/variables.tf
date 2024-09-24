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

# Kubernetes Variables
variable "name" {
  description = "The name of the node pool."
  type        = string
}

# This should be kept synced with node_config in cluster
variable "config" {
  description = "The node configuration of the pool."
  type = object({
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
  })
  default = null
}

variable "initialNodeCount" {
  description = "The initial node count for the pool"
  type        = number
  default     = null
}

variable "locations" {
  description = "The list of Google Compute Engine zones in which the NodePool's nodes should be located."
  type        = list(string)
  default     = null
}

variable "networkConfig" {
  description = "Networking configuration for this NodePool."
  type = object({
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
  })
  default = null
}

variable "selfLink" {
  description = "[Output only] Server-defined URL for the resource."
  type        = string
  default     = null
}

variable "nodeVersion" {
  description = "The version of Kubernetes running on this NodePool's nodes."
  type        = string
  default     = null
}

variable "instanceGroupUrls" {
  description = "[Output only] The resource URLs of the managed instance groups associated with this node pool."
  type        = list(string)
  default     = null
}

variable "status" {
  description = "[Output only] The status of the nodes in this pool instance."
  type        = string
  default     = null
}

variable "statusMessage" {
  description = "[Output only] Deprecated. Use conditions instead."
  type        = string
  default     = null
}

variable "autoscaling" {
  description = "Autoscaler configuration for this NodePool."
  type = object({
    enabled           = optional(bool, null)
    minNodeCount      = optional(number, null)
    maxNodeCount      = optional(number, null)
    autoprovisioned   = optional(bool, null)
    locationPolicy    = optional(string, null)
    totalMinNodeCount = optional(number, null)
    totalMaxNodeCount = optional(number, null)
  })
  default = null
}

variable "management" {
  description = "NodeManagement configuration for this NodePool."
  type = object({
    autoUpgrade = optional(bool, null)
    autoRepair  = optional(bool, null)
    upgradeOptions = optional(object({
      autoUpgradeStartTime = optional(string, null)
      description          = optional(string, null)
    }))
  })
  default = null
}

variable "maxPodsConstraint" {
  description = "The constraint on the maximum number of pods that can be run simultaneously on a node in the node pool."
  type = object({
    maxPodsPerNode = optional(string, null)
  })
  default = null
}

variable "conditions" {
  description = "Which conditions caused the current node pool state."
  type = list(object({
    code          = optional(string, null) # depricated
    message       = optional(string, null)
    canonicalCode = optional(string, null)
  }))
  default = null
}

variable "podIpv4CidrSize" {
  description = "[Output only] The pod CIDR block size per node in this node pool."
  type        = number
  default     = null
}

variable "upgradeSettings" {
  description = "Upgrade settings control disruption and speed of the upgrade."
  type = object({
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
  })
  default = null
}

variable "placementPolicy" {
  description = "Specifies the node placement policy."
  type = object({
    type        = optional(string, null)
    tpuTopology = optional(string, null)
    policyName  = optional(string, null)
  })
  default = null
}

variable "updateInfo" {
  description = "[Output only] Update info contains relevant information during a node pool update."
  type = object({
    phase                     = optional(string, null)
    blueInstanceGroupUrls     = optional(list(string), null)
    greenInstanceGroupUrls    = optional(list(string), null)
    bluePoolDeletionStartTime = optional(string, null)
    greenPoolVersion          = optional(string, null)
  })
  default = null
}

variable "etag" {
  description = "This checksum is computed by the server based on the value of node pool fields"
  type        = string
  default     = null
}

variable "queuedProvisioning" {
  description = "Specifies the configuration of queued provisioning."
  type = object({
    enabled = optional(bool, null)
  })
  default = null
}

variable "bestEffortProvisioning" {
  description = "Enable best effort provisioning for nodes"
  type = object({
    enabled           = optional(bool, null)
    minProvisionNodes = optional(number, null)
  })
  default = null
}
