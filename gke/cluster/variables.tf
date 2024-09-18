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

variable "description" {
  description = "The description of the cluster"
  type        = string
  default     = null
}

variable "timeouts" {
  description = "Terraform timeout values"
  type        = object({})
  default     = null
}

variable "remove_default_node_pool" {
  description = "Remove default nodes?"
  type        = bool
  default     = true
}

variable "initial_node_count" {
  description = "Initial Node Count"
  type        = number
  default     = 1
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
    kubernetesDashboard = optional(object({
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
    # Beta
    # istioConfig = optional(object({
    #   disabled = optional(bool, null)
    #   auth     = optional(string, null)
    # }), null)
    gkeBackupAgentConfig = optional(object({
      enabled = optional(bool, null)
    }), null)
    # Beta
    # kalmConfig = optional(object({
    #   enabled = optional(bool, null)
    # }), null)
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
    # kubernetesDashboard = optional(object({}), null) Deprecated
  })
  default = null
}

variable "autopilot" {
  description = "Enable autopilot for this cluster, default in GKE is false"
  type = object({
    enabled = optional(bool, null)
  })
  default = null
}

variable "autoscaling" {
  description = "Configuration of Node Auto-Provisioning with Cluster Autoscaler for this cluster"
  type = object({
    autoprovisioningNodePoolDefaults = optional(object({
      bootDiskKmsKey = optional(string, null)
      diskType       = optional(string, null)
      diskSize       = optional(string, null)
      imageType      = optional(string, null)
      management = optional(object({
        autoRepair  = optional(bool, null)
        autoUpgrade = optional(bool, null)
      }), null)
      oauthScopes    = optional(list(string), null)
      serviceAccount = optional(string, null)
      upgradeSettings = optional(object({
        maxSurge = optional(number, null)
        strategy = optional(string, null)
      }), null)
    }), null)
    autoscalingProfile         = optional(string, null)
    enableNodeAutoProvisioning = optional(bool, null)
    resourceLimits = optional(list(object({
      resourceType = string
      minimum      = optional(string, null)
      maximum      = optional(string, null)
    })), null)
  })
  default = null
}

variable "binaryAuthorization" {
  description = "Configuration options for the Binary Authorization feature"
  type        = object({})
  default     = null
}

variable "clusterIpv4Cidr" {
  description = "The IP address range of the Kubernetes pods in this cluster in CIDR notation"
  type        = string
  default     = null
}

# createTime: '2024-06-03T18:07:48+00:00'

variable "currentMasterVersion" {
  description = "The current version of the master"
  type        = string
  default     = null
}

variable "currentNodeVersion" {
  description = "The current version of the nodes"
  type        = string
  default     = null
}

variable "databaseEncryption" {
  description = "Encyption settings for etcd"
  type = object({
    # currentState = optional(string, null)
    state   = optional(string, null)
    keyName = optional(string, null)
  })
  default = null
}

variable "defaultMaxPodsConstraint" {
  description = ""
  type = object({
    maxPodsPerNode = optional(number, null)
  })
  default = null
}

variable "fleet" {
  description = "fleet"
  type = object({
    membership = optional(string, null)
    project    = optional(string, null)
  })
}

# endpoint: 100.88.2.2
# enterpriseConfig:
#   clusterTier: STANDARD
# etag: 64b88d66-b05c-418c-b485-58041ab7e38d
# id: a527f01905f04ad18d02748b36036c676632306657644b55b7a794ae5ba55285
# instanceGroupUrls:

variable "initialClusterVersion" {
  description = "The minimum version of the master"
  type        = string
  default     = null
}

variable "ipAllocationPolicy" {
  description = "The allocation policy for the ip ranges"
  type = object({
    clusterIpv4Cidr            = optional(string, null)
    clusterIpv4CidrBlock       = optional(string, null)
    clusterSecondaryRangeName  = optional(string, null)
    podCidrOverprovisionConfig = optional(map(any), null)
    servicesIpv4Cidr           = optional(string, null)
    servicesIpv4CidrBlock      = optional(string, null)
    servicesSecondaryRangeName = optional(string, null)
    stackType                  = optional(string, null)
    useIpAliases               = optional(bool, null)
    additionalPodRangesConfig = optional(object({
      podRangeNames = optional(list(string), null)
      podRangeInfo = optional(list(object({
        rangeName   = optional(string, null)
        utilization = optional(number, null)
      })), null)
    }), null)
  })
}

# labelFingerprint: a9dc16a7
# legacyAbac: {}

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
  description = "The maintenance policy to use for the cluster"
  type = object({
    window = optional(object({
      recurringWindow = optional(object({
        recurrence = optional(string, null)
        window = optional(object({
          startTime = optional(string, null)
          endTime   = optional(string, null)
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
  })
  default = null
}

variable "masterAuth" {
  description = "The authentication information for accessing the Kubernetes master"
  type = object({
    clientCertificateConfig = optional(object({
      issueClientCertificate = optional(bool, null)
    }), null)
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

variable "monitoringConfig" {
  description = "Monitoring configuration for the cluster"
  type = object({
    advancedDatapathObservabilityConfig = optional(object({
      enableMetrics = optional(bool, null)
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
    datapathProvider = optional(string, null)
    defaultSnatStatus = optional(object({
      disabled = optional(bool, null)
    }), null)
    dnsConfig = optional(object({
      clusterDns       = optional(string, null)
      clusterDnsDomain = optional(string, null)
      clusterDnsScope  = optional(string, null)
    }), null)
    enableIntraNodeVisibility = optional(bool, null)
    gatewayApiConfig = optional(object({
      channel = optional(string, null)
    }), null)
    network = optional(string, null)
    serviceExternalIpsConfig = optional(object({
      enabled = optional(bool, null)
    }), null)
    subnetwork = optional(string, null)
  })
  default = null
}

variable "nodeConfig" {
  description = "Parameters used in creating the default node pool"
  type = object({
    bootDiskKmsKey = optional(string, null)
    diskSizeGb     = optional(number, null)
    diskTye        = optional(string, null)
    imageType      = optional(string, null)
    machineType    = optional(string, null)
    metadata       = optional(map(string), null)
    oauthScopes    = optional(list(string), null)
    reservationAffinity = optional(object({
      consumeReservationType = optional(string, null)
    }), null)
    serviceAccount = optional(string, null)
    shieldedInstanceConfig = optional(object({
      enableIntegrityMonitoring = optional(bool, null)
      enableSecureBoot          = optional(bool, null)
    }), null)
    taints = optional(list(object({
      effect = optional(string, null)
      key    = optional(string, null)
      value  = optional(string, null)
    })), null)
    gvnic = optional(object({
      enabled = optional(bool, null)
    }), null)
    windowsNodeConfig = optional(object({}), null)
    workloadMetadataConfig = optional(object({
      mode = optional(string, null)
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
              secretURI = optional(string, null)
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
        insecureKubeletReadonlyPortEnabled = optional(bool, null)
      }), null)
    }), null)
  })
  default = null
}

variable "notificationConfig" {
  description = "Configuration for the cluster upgrade notifications feature"
  type = object({
    pubsub = optional(object({}), null)
  })
  default = null
}

variable "privateClusterConfig" {
  description = "The private configuration of the cluster"
  type = object({
    enablePrivateEndpoint     = optional(bool, false)
    enablePrivateNodes        = optional(bool, false)
    masterIpv4CidrBlock       = optional(string, null)
    privateEndpointSubnetwork = optional(string, null)
    masterGlobalAccessConfig = optional(object({
      enabled = optional(bool, false)
    }), null)
  })
  default = null
}

variable "releaseChannel" {
  description = "The release channel for the cluster"
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

variable "securityPostureConfig" {
  description = "Enable/Disable Security Posture API features for the cluster"
  type = object({
    mode              = optional(string, null)
    vulnerabilityMode = optional(string, null)
  })
  default = null
}

# selfLink = output only
# serviceIpvCidr = output only

variable "shieldedNodes" {
  description = "Enable Shielded Nodes features on all nodes in this cluster"
  type = object({
    enabled = optional(bool, null)
  })
  default = null
}

# status = output only

variable "subnetwork" {
  description = "The subnetwork for the nodes"
  type        = string
  default     = null
}

variable "verticalPodAutoscaling" {
  description = "Enable vertical pod autoscaling"
  type = object({
    enabled = optional(bool, null)
  })
  default = null
}

variable "workloadIdentityConfig" {
  description = "Workload Identity allows Kubernetes service accounts to act as a user-managed Google IAM Service Account"
  type = object({
    workloadPool = optional(string, null)
  })
  default = null
}

# zone = output only


