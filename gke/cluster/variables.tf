# Terraform variables
variable "project" {
  description = "The project for the cluster"
  type        = string
}

variable "deletion_protection" {
  description = "Whether or not to allow Terraform to destroy the cluster"
  type        = bool
  default     = false
}

variable "remove_default_node_pool" {
  description = "Remove default nodes?"
  type        = bool
  default     = true
}

variable "timeouts" {
  description = "Terraform timeout values"
  type        = object({})
  default     = null
}

# Kubernetes variables
variable "addonsConfig" {
  description = "The configuration for addons supported by GKE"
  type = object({
    dnsCacheConfig = optional(object({
      enabled = optional(bool, null)
    }), null)
    gcePersistentDiskCsiDriverConfig = optional(object({
      enabled = optional(bool, null)
    }), null)
    gcpFilestoreCsiDriverConfig = optional(object({
      enabled = optional(bool, null)
    }), null)
    gcsFuseCsiDriverConfig = optional(object({
      enabled = optional(bool, null)
    }), null)
    horizontalPodAutoscaling = optional(object({
      disabled = optional(bool, null)
    }), null)
    httpLoadBalancing = optional(object({
      disabled = optional(bool, null)
    }), null)
    kubernetesDashboard = optional(object({ # deprecated
      enabled = optional(bool, null)
    }), null)
    networkPolicyConfig = optional(object({
      disabled = optional(bool, null)
    }), null)
    statefulHaConfig = optional(object({
      enabled = optional(bool, null)
    }), null)
    cloudrunConfig = optional(object({
      disabled         = optional(bool, null)
      loadBalancerType = optional(string, null)
    }), null)
    gkeBackupAgentConfig = optional(object({
      enabled = optional(bool, null)
    }), null)
    configConnectorConfig = optional(object({
      enabled = optional(bool, null)
    }), null)
    rayOperatorConfig = optional(object({
      enabled = optional(bool, null)
      rayClusterLoggingConfig = optional(object({
        enabled = optional(bool, null)
      }), null)
      rayClusterMonitoringConfig = optional(object({
        enabled = optional(bool, null)
      }), null)
    }), null)
  })
  default = null
}

variable "authenticatorGroupsConfig" {
  description = "Configuration for returning group information from authenticators."
  type = object({
    enabled       = optional(bool, null)
    securityGroup = optional(string, null)
  })
  default = null
}

variable "autopilot" {
  description = "Enable autopilot for this cluster, default in GKE is false"
  type = object({
    enabled = optional(bool, null)
    workloadPolicyConfig = optional(object({
      allowNetAdmin = optional(bool, null)
    }), null)
  })
  default = null
}

variable "autoscaling" {
  description = "Configuration of Node Auto-Provisioning with Cluster Autoscaler for this cluster"
  type = object({
    enableNodeAutoProvisioning = optional(bool, null)
    resourceLimits = optional(list(object({
      resourceType = string
      minimum      = optional(string, null)
      maximum      = optional(string, null)
    })), null)
    autoscalingProfile = optional(string, null)
    autoprovisioningNodePoolDefaults = optional(object({
      oauthScopes    = optional(list(string), null)
      serviceAccount = optional(string, null)
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
          nodePoolSoakDuration = optional(string, null)
        }), null)
      }), null)
      management = optional(object({
        autoRepair  = optional(bool, null)
        autoUpgrade = optional(bool, null)
        upgradeOptions = optional(object({
          autoUpgradeStartTime = optional(string, null)
          description          = optional(string, null)
        }), null)
      }), null)
      minCpuPlatform = optional(string, null)
      diskSizeGb     = optional(string, null)
      diskType       = optional(string, null)
      shieldedInstanceConfig = optional(object({
        enableSecureBoot          = optional(bool, null)
        enableIntegrityMonitoring = optional(bool, null)
      }), null)
      bootDiskKmsKey                     = optional(string, null)
      imageType                          = optional(string, null)
      insecureKubeletReadonlyPortEnabled = optional(string, null)
    }), null)
    autoprovisioningLocations = optional(list(string), null)
  })
  default = null
}

variable "binaryAuthorization" {
  description = "Configuration for Binary Authorization."
  type = object({
    enabled        = optional(bool, null) # depricated
    evaluationMode = optional(string, null)
  })
  default = null
}

variable "clusterIpv4Cidr" {
  description = "The IP address range of the Kubernetes pods in this cluster in CIDR notation"
  type        = string
  default     = null
}

variable "confidentialNodes" {
  description = "ConfidentialNodes is configuration for the confidential nodes feature, which makes nodes run on confidential VMs."
  type = object({
    enabled = optional(bool, null)
  })
  default = null
}

variable "costManagementConfig" {
  description = "Configuration for fine-grained cost management feature."
  type = object({
    enabled = optional(bool, null)
  })
  default = null
}

variable "createTime" {
  description = "Output Only"
  type        = string
  default     = null
}

variable "currentMasterVersion" {
  description = "The current version of the master"
  type        = string
  default     = null
}

variable "currentNodeCount" {
  description = "Output Only?"
  type        = number
  default     = null
}

variable "currentNodeVersion" {
  description = "The current version of the nodes"
  type        = string
  default     = null
}

variable "conditions" {
  description = ""
  type = list(object({
    code          = optional(string, null) # depricated
    message       = optional(string, null)
    canonicalCode = optional(string, null)
  }))
  default = null
}


variable "databaseEncryption" {
  description = "Encyption settings for etcd"
  type = object({
    state          = optional(string, null)
    keyName        = optional(string, null)
    decryptionKeys = optional(list(string), null)
    lastOperationErrors = optional(list(object({
      keyName      = optional(string, null)
      errorMessage = optional(string, null)
      timestamp    = optional(string, null)
    })), null)
    currentState = optional(string, null)
  })
  default = null
}

variable "defaultMaxPodsConstraint" {
  description = "Constraints applied to pods."
  type = object({
    maxPodsPerNode = optional(number, null)
  })
  default = null
}

variable "description" {
  description = "The description of the cluster"
  type        = string
  default     = null
}

variable "enableKubernetesAlpha" {
  description = ""
  type        = bool
  default     = null
}

variable "enableK8sBetaApis" {
  description = "K8sBetaAPIConfig , configuration for beta APIs"
  type = object({
    enabledApis = optional(list(string), null)
  })
  default = null
}

variable "enableTpu" {
  description = ""
  type        = bool
  default     = null
}

variable "endpoint" {
  description = "Output Only"
  type        = string
  default     = null
}

variable "enterpriseConfig" {
  description = "EnterpriseConfig is the cluster enterprise configuration."
  type = object({
    clusterTier = optional(string, null)
  })
  default = null
}

variable "etag" {
  description = "Output Only"
  type        = bool
  default     = null
}

variable "expireTime" {
  description = ""
  type        = string
  default     = null
}

variable "fleet" {
  description = "fleet"
  type = object({
    membership    = optional(string, null)
    project       = optional(string, null)
    preRegistered = optional(bool, null)
  })
}

variable "id" {
  description = ""
  type        = string
  default     = null
}

variable "identityServiceConfig" {
  description = "IdentityServiceConfig is configuration for Identity Service which allows customers to use external identity providers with the K8S API"
  type = object({
    enabled = optional(bool, null)
  })
  default = null
}

variable "initialClusterVersion" {
  description = "The minimum version of the master"
  type        = string
  default     = null
}

variable "initialNodeCount" {
  description = "initial Node Count"
  type        = number
  default     = 1
}

variable "instanceGroupUrls" {
  description = "Output Only"
  type        = list(string)
  default     = null
}

variable "ipAllocationPolicy" {
  description = "The allocation policy for the ip ranges"
  type = object({
    useIpAliases               = optional(bool, null)
    createSubnetwork           = optional(bool, null)
    subnetworkName             = optional(string, null)
    clusterIpv4Cidr            = optional(string, null)
    nodeIpv4Cidr               = optional(string, null)
    servicesIpv4Cidr           = optional(string, null)
    clusterSecondaryRangeName  = optional(string, null)
    servicesSecondaryRangeName = optional(string, null)
    clusterIpv4CidrBlock       = optional(string, null)
    nodeIpv4CidrBlock          = optional(string, null)
    servicesIpv4CidrBlock      = optional(string, null)
    tpuIpv4CidrBlock           = optional(string, null)
    useRoutes                  = optional(bool, null)
    stackType                  = optional(string, null)
    ipv6AccessType             = optional(string, null)
    podCidrOverprovisionConfig = optional(object({
      disable = optional(bool, null)
    }), null)
    subnetIpv6CidrBlock   = optional(string, null)
    servicesIpv6CidrBlock = optional(string, null)
    additionalPodRangesConfig = optional(object({
      podRangeNames = optional(list(string), null)
      podRangeInfo = optional(list(object({
        rangeName   = optional(string, null)
        utilization = optional(number, null)
      })), null)
    }), null)
    defaultPodIpv4RangeUtilization = optional(number, null)
  })
}

variable "legacyAbac" {
  description = "Configuration for the legacy Attribute Based Access Control authorization mode"
  type = object({
    enabled = optional(bool, null)
  })
  default = null
}

variable "labelFingerprint" {
  description = "Label Fingerprint"
  type        = string
  default     = null
}

variable "location" {
  description = "The location of the cluster for regional clusters"
  type        = string
  default     = null
}

variable "locations" {
  description = "The zones for the nodes or single zone for a zonal cluster"
  type        = list(string)
  default     = null
}

variable "loggingConfig" {
  description = "Logging configuration for the cluster"
  type = object({
    componentConfig = optional(object({
      enableComponents = optional(list(string), null)
    }), null)
  })
  default = null
}

variable "loggingService" {
  description = "The logging service that the cluster should write logs to"
  type        = string
  default     = null
}

variable "maintenancePolicy" {
  description = "MaintenancePolicy defines the maintenance policy to be used for the cluster"
  type = object({
    window = optional(object({
      recurringWindow = optional(object({
        recurrence = optional(string, null)
        window = optional(object({
          startTime = optional(string, null)
          endTime   = optional(string, null)
          maintenanceExclusionOptions = optional(object({
            scope = optional(string, null)
          }), null)
        }), null)
      }), null)
      dailyMaintenanceWindow = optional(object({
        duration  = optional(string, null)
        startTime = optional(string, null)
      }), null)
      maintenanceExclusions = optional(map(object({
        startTime = optional(string, null)
        endTime   = optional(string, null)
        maintenanceExclusionOptions = optional(object({
          scope = optional(string, null)
        }), null)
      })), null)
    }), null)
    resourceVersion = optional(string, null)
  })
  default = null
}

variable "masterAuth" {
  description = "The authentication information for accessing the Kubernetes master"
  type = object({
    clientCertificateConfig = optional(object({
      issueClientCertificate = optional(bool, null)
    }), null)
    clusterCaCertificate = optional(string, null) # output only
    clientCertificate    = optional(string, null) # output only
    clientKey            = optional(string, null) # output only
  })
  default = null
}

variable "masterAuthorizedNetworksConfig" {
  description = "The desired configuration options for master authorized networks"
  type = object({
    cidrBlocks = optional(list(object({
      cidrBlock   = string
      displayName = optional(string, null)
    })))
    enabled                     = optional(bool, null)
    gcpPublicCidrsAccessEnabled = optional(bool, null)
  })
  default = null
}

variable "meshCertificates" {
  description = "Configuration for issuance of mTLS keys and certificates to Kubernetes pods."
  type = object({
    enableCertificates = optional(bool, null)
  })
  default = null
}

variable "monitoringConfig" {
  description = "Monitoring configuration for the cluster"
  type = object({
    advancedDatapathObservabilityConfig = optional(object({
      enableMetrics = optional(bool, null)
      relayMode     = optional(string, null)
      enableRelay   = optional(bool, null)
    }), null)
    componentConfig = optional(object({
      enableComponents = optional(list(string), null)
    }), null)
    managedPrometheusConfig = optional(object({
      enabled = optional(bool, null)
    }), null)
  })
  default = null
}

variable "monitoringService" {
  description = "he monitoring service that the cluster should write metrics to"
  type        = string
  default     = null
}

variable "name" {
  description = "The name of the cluster"
  type        = string
}

variable "network" {
  description = "The network for the cluster"
  type        = string
}

variable "networkConfig" {
  description = "The network configuration for the cluster"
  type = object({
    network                   = optional(string, null)
    subnetwork                = optional(string, null)
    enableIntraNodeVisibility = optional(bool, null)
    defaultSnatStatus = optional(object({
      disabled = optional(bool, null)
    }), null)
    enableL4ilbSubsetting   = optional(bool, null)
    datapathProvider        = optional(string, null)
    privateIpv6GoogleAccess = optional(string, null)
    dnsConfig = optional(object({
      clusterDns                = optional(string, null)
      clusterDnsDomain          = optional(string, null)
      clusterDnsScope           = optional(string, null)
      additiveVpcScopeDnsDomain = optional(string, null)
    }), null)
    serviceExternalIpsConfig = optional(object({
      enabled = optional(bool, null)
    }), null)
    gatewayApiConfig = optional(object({
      channel = optional(string, null)
    }), null)
    enableMultiNetworking = optional(bool, null)
    networkPerformanceConfig = optional(object({
      totalEgressBandwidthTier = optional(string, null)
    }), null)
    enableFqdnNetworkPolicy              = optional(bool, null)
    inTransitEncryptionConfig            = optional(string, null)
    enableCiliumClusterwideNetworkPolicy = optional(bool, null)
  })
  default = null
}

variable "networkPolicy" {
  description = "Configuration options for the NetworkPolicy feature."
  type = object({
    provider = optional(string, null)
    enabled  = optional(bool, null)
  })
  default = null
}

# This should be kept synced with config in node_pool
variable "nodeConfig" {
  description = "Parameters that describe the nodes in a cluster"
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

variable "nodeIpv4CidrSize" {
  description = ""
  type        = number
  default     = null
}

variable "nodePoolAutoConfig" {
  description = ""
  type = object({
    networkTags = optional(object({
      tags = optional(list(string), null)
    }), null)
    resourceManagerTags = optional(object({
      tags = optional(map(string), null)
    }), null)
    nodeKubeletConfig = optional(object({
      cpuManagerPolicy                   = optional(string, null)
      cpuCfsQuota                        = optional(bool, null)
      cpuCfsQuotaPeriod                  = optional(string, null)
      podPidsLimit                       = optional(string, null)
      insecureKubeletReadonlyPortEnabled = optional(bool, null)
    }), null)
  })
  default = null
}

variable "nodePoolDefaults" {
  description = "Default NodePool settings for the entire cluster"
  type = object({
    nodeConfigDefaults = optional(object({
      containerdConfig = optional(object({
        privateRegistryAccessConfig = optional(object({
          certificateAuthorityDomainConfig = optional(list(object({
            fqdns = optional(list(string), null)
            gcpSecretManagerCertificateConfig = optional(object({
              secretUri = optional(string, null)
            }), null)
          })), null)
        }), null)
      }), null)
      gcfsConfig = optional(object({
        enabled = optional(bool, null)
      }), null)
      loggingConfig = optional(object({
        variantConfig = optional(object({
          variant = optional(string, null)
        }), null)
      }), null)
      nodeKubeletConfig = optional(object({
        cpuManagerPolicy                   = optional(string, null)
        cpuCfsQuota                        = optional(bool, null)
        cpuCfsQuotaPeriod                  = optional(string, null)
        podPidsLimit                       = optional(string, null)
        insecureKubeletReadonlyPortEnabled = optional(bool, null)
      }), null)
    }), null)
  })
  default = null
}

variable "notificationConfig" {
  description = "Configuration for the cluster upgrade notifications feature"
  type = object({
    pubsub = optional(object({
      enabled = optional(bool, null)
      topic   = optional(string, null)
      filter = optional(object({
        eventType = optional(list(string), null)
      }), null)
    }), null)
  })
  default = null
}

variable "parentProductConfig" {
  description = "ParentProductConfig is the configuration of the parent product of the cluster"
  type = object({
    productName = optional(string, null)
    labels      = optional(map(string), null)
  })
  default = null
}

variable "privateClusterConfig" {
  description = "The private configuration of the cluster"
  type = object({
    enablePrivateNodes        = optional(bool, false)
    enablePrivateEndpoint     = optional(bool, false)
    masterIpv4CidrBlock       = optional(string, null)
    privateEndpoint           = optional(string, null)
    publicEndpoint            = optional(string, null)
    peeringName               = optional(string, null)
    privateEndpointSubnetwork = optional(string, null)
    masterGlobalAccessConfig = optional(object({
      enabled = optional(bool, false)
    }), null)
  })
  default = null
}

variable "releaseChannel" {
  description = "ReleaseChannel indicates which release channel a cluster is subscribed to."
  type = object({
    channel = optional(string, null)
  })
  default = null
}

variable "resourceLabels" {
  description = "The GCE resource labels (a map of key/value pairs) to be applied to the cluster"
  type        = map(string)
  default     = null
}

variable "resourceUsageExportConfig" {
  description = "Configuration for exporting cluster resource usages."
  type = object({
    bigqueryDestination = optional(object({
      datasetId = optional(string, null)
    }), null)
    enableNetworkEgressMetering = optional(bool, null)
    consumptionMeteringConfig = optional(object({
      enabled = optional(bool, null)
    }), null)
  })
  default = null
}

variable "satisfiesPzs" {
  description = ""
  type        = bool
  default     = null
}

variable "satisfiesPzi" {
  description = ""
  type        = bool
  default     = null
}

variable "securityPostureConfig" {
  description = "SecurityPostureConfig defines the flags needed to enable/disable features for the Security Posture API."
  type = object({
    mode              = optional(string, null)
    vulnerabilityMode = optional(string, null)
  })
  default = null
}

variable "selfLink" {
  description = "Output Only"
  type        = string
  default     = null
}

variable "servicesIpv4Cidr" {
  description = ""
  type        = string
  default     = null
}

variable "shieldedNodes" {
  description = "Configuration of Shielded Nodes feature."
  type = object({
    enabled = optional(bool, null)
  })
  default = null
}

variable "status" {
  description = "Output Only"
  type        = string
  default     = null
}

variable "statusMessage" {
  description = "Output Only"
  type        = string
  default     = null
}

variable "subnetwork" {
  description = "The subnetwork for the nodes"
  type        = string
  default     = null
}

variable "tpuIpv4CidrBlock" {
  description = ""
  type        = string
  default     = null
}

variable "verticalPodAutoscaling" {
  description = "VerticalPodAutoscaling contains global, per-cluster information required by Vertical Pod Autoscaler to automatically adjust the resources of pods controlled by it."
  type = object({
    enabled = optional(bool, null)
  })
  default = null
}

variable "workloadIdentityConfig" {
  description = "Configuration for the use of Kubernetes Service Accounts in GCP IAM policies."
  type = object({
    workloadPool = optional(string, null)
  })
  default = null
}

variable "zone" {
  description = "Output Only"
  type        = string
  default     = null
}
