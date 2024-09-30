# Terraform variables
variable "project" {
  description = "The project for the compute instance"
  type        = string
}

variable "allow_stopping_for_update" {
  description = "??"
  type        = bool
  default     = null
}

variable "metadata_startup_script" {
  description = "This is a hack for terraform?"
  type        = string
  default     = null
}

# GCE Variables
variable "name" {
  description = "The name of the compute instance"
  type        = string
}

variable "description" {
  description = "The description of the compute instance"
  type        = string
  default     = null
}

variable "tags" {
  description = "The tags for the compute instance"
  type = object({
    items       = optional(list(string), null)
    fingerprint = optional(string, null)
  })
  default = null
}

variable "machineType" {
  description = "The machine type for the instance"
  type        = string
  default     = null
}

#   "status": enum,
#   "statusMessage": string,

variable "zone" {
  description = "The zone for the instance"
  type        = string
  default     = null
}

variable "canIpForward" {
  description = "Can the instance ip forward"
  type        = bool
  default     = null
}

variable "networkInterfaces" {
  description = "The network interfaces on the instance"
  type = list(object({
    kind                     = optional(string, null)
    network                  = optional(string, null)
    subnetwork               = optional(string, null)
    networkIP                = optional(string, null)
    ipv6Address              = optional(string, null)
    internalIpv6PrefixLength = optional(string, null)
    name                     = optional(string, null)
    accessConfigs = optional(list(object({
      kind                = optional(string, null)
      type                = optional(string, null)
      name                = optional(string, null)
      natIP               = optional(string, null)
      externalIpv6        = optional(string, null)
      setPublicPtr        = optional(bool, null)
      publicPtrDomainName = optional(string, null)
      networkTier         = optional(string, null)
      securityPolicy      = optional(string, null)
    })), null)
    ipv6AccessConfigs = optional(object({
      kind                     = optional(string, null)
      type                     = optional(string, null)
      name                     = optional(string, null)
      natIP                    = optional(string, null)
      externalIpv6             = optional(string, null)
      externalIpv6PrefixLength = optional(number, null)
      setPublicPtr             = optional(bool, null)
      publicPtrDomainName      = optional(string, null)
      networkTier              = optional(string, null)
      securityPolicy           = optional(string, null)
    }), null)
    aliasRanges = optional(list(object({
      ipCidrRange         = optional(string, null)
      subnetworkRangeName = optional(string, null)
    })), null)
    fingerprint       = optional(string, null)
    stackType         = optional(string, null)
    ipv6AccessType    = optional(string, null)
    queyCount         = optional(number, null)
    nicType           = optional(string, null)
    networkAttachment = optional(string, null)
  }))
  default = null
}

variable "disks" {
  description = "The disks for the compute instance"
  type = list(object({
    kind       = optional(string, null)
    type       = optional(string, null)
    mode       = optional(string, null)
    savedState = optional(string, null)
    source     = optional(string, null)
    deviceName = optional(string, null)
    index      = optional(string, null)
    boot       = optional(bool, null)
    initializeParms = optional(object({
      diskName    = optional(string, null)
      sourceImage = optional(string, null)
      diskSizeGb  = optional(string, null)
      diskType    = optional(string, null)
      sourceImageEncryptionKey = optional(object({
        rawKey               = optional(string, null)
        rsaEncryptedKey      = optional(string, null)
        kmsKeyName           = optional(string, null)
        sha256               = optional(string, null)
        kmsKeyServiceAccount = optional(string, null)
      }), null)
      label          = optional(map(string), null)
      sourceSnapshot = optional(string, null)
      sourceSnapshotEncryptionKey = optional(object({
        rawKey               = optional(string, null)
        rsaEncryptedKey      = optional(string, null)
        kmsKeyName           = optional(string, null)
        sha256               = optional(string, null)
        kmsKeyServiceAccount = optional(string, null)
      }), null)
      description               = optional(string, null)
      replicaZones              = optional(list(string), null)
      resourcePolicies          = optional(list(string), null)
      onUpdateAction            = optional(string, null)
      provisionedIops           = optional(string, null)
      licenses                  = optional(list(string), null)
      architecture              = optional(string, null)
      resourceTags              = optional(map(string), null)
      provisionedThroughput     = optional(string, null)
      enableConfidentialCompute = optional(bool, null)
      storagePool               = optional(string, null)
    }), null)
    autoDelete = optional(bool, null)
    licenses   = optional(list(string), null)
    interface  = optional(string, null)
    guestOsFeatures = optional(list(object({
      type = optional(string, null)
    })), null)
    diskEncryptionKey = optional(object({
      sha256               = optional(string, null)
      kmsKeyServiceAccount = optional(string, null)
      rawKey               = optional(string, null)
      rsaEncryptedKey      = optional(string, null)
      kmsKeyName           = optional(string, null)
    }), null)
    diskSizeGb = optional(string, null)
    shieldedInstanceInitialState = optional(object({
      pk = optional(object({
        content  = optional(string, null)
        fileType = optional(string, null)
      }), null)
      keks = optional(list(object({
        content  = optional(string, null)
        fileType = optional(string, null)
      })), null)
      dbs = optional(list(object({
        content  = optional(string, null)
        fileType = optional(string, null)
      })), null)
      dbxs = optional(list(object({
        content  = optional(string, null)
        fileType = optional(string, null)
      })), null)
    }), null)
    forceAttach  = optional(bool, null)
    architecture = optional(string, null)
  }))
  default = null
}

variable "metadata" {
  description = "The metadata for the instance"
  type = object({
    kind        = optional(string, null)
    fingerprint = optional(string, null)
    items = optional(list(object({
      key   = optional(string, null)
      value = optional(string, null)
    })), null)
  })
  default = null
}

variable "serviceAccounts" {
  description = "The service accounts for the instance"
  type = list(object({
    email  = optional(string, null)
    scopes = optional(list(string), null)
  }))
  default = null
}

#   "selfLink": string,

variable "scheduling" {
  description = "The scheduling for the instance"
  type = object({
    onHostMaintenance = optional(string, null)
    automaticRestart  = optional(bool, null)
    preemptible       = optional(bool, null)
    nodeAffinities = optional(list(object({
      key      = optional(string, null)
      operator = optional(string, null)
      values   = optional(list(string), null)
    })), null)
    minNodeCpus               = optional(number, null)
    locationHint              = optional(string, null)
    availabilityDomain        = optional(number, null)
    provisioningModel         = optional(string, null)
    instanceTerminationAction = optional(string, null)
    maxRunDuration = optional(object({
      seconds = optional(string, null)
      nanos   = optional(number, null)
    }), null)
    terminationTime = optional(string, null)
    onInstanceStopAction = optional(object({
      discardLocalSsd = optional(bool, null)
    }), null)
    localSsdRecoveryTimeout = optional(object({
      seconds = optional(string, null)
      nanos   = optional(number, null)
    }), null)
    cpuPlatform = optional(string, null)
    labels      = optional(map(string), null)
    params = optional(object({
      resourceManagerTags = optional(map(string), null)
    }), null)
  })
  default = null
}

#   "labelFingerprint": string,

variable "instanceEncryptionKey" {
  description = "The encryption key for the instance"
  type = object({
    rawKey                = optional(string, null)
    rrsaEncryptedKey      = optional(string, null)
    kmsKeyName            = optional(string, null)
    rsha256               = optional(string, null)
    rkmsKeyServiceAccount = optional(string, null)
  })
  default = null
}

variable "minCpuPlatform" {
  description = "The minimum CPU platform"
  type        = string
  default     = null
}

variable "guestAccelerators" {
  description = "Guest Accelerators"
  type = list(object({
    acceleratorType  = optional(string, null)
    acceleratorCount = optional(number, null)
  }))
  default = null
}

variable "startRestricted" {
  description = "Start Restricted"
  type        = bool
  default     = null
}

variable "deletionProtection" {
  description = "Prevent the instance from being deleted by terraform"
  type        = bool
  default     = null
}

variable "resourcePolicies" {
  description = "Resource Policies"
  type        = list(string)
  default     = null
}

variable "sourceMachineImage" {
  description = "source machine image"
  type        = string
  default     = null
}

variable "reservationAffinity" {
  description = "Reservation Addinity"
  type = object({
    consumeReservationType = optional(string, null)
    key                    = optional(string, null)
    values                 = optional(list(string), null)
  })
}

variable "hostname" {
  description = "Hostname"
  type        = string
  default     = null
}

variable "displayDevice" {
  description = "Display Device"
  type = object({
    enableDisplay = optional(bool, null)
  })
  default = null
}

variable "shieldedInstanceConfig" {
  description = "Shielded Instance Config"
  type = object({
    enableSecureBoot          = optional(bool, null)
    enableVtpm                = optional(bool, null)
    enableIntegrityMonitoring = optional(bool, null)
  })
  default = null
}

variable "shieldedInstanceIntegrityPolicy" {
  description = "Shielded Instance Integrity Policy"
  type = object({
    updateAutoLearnPolicy = optional(bool, null)
  })
  default = null
}

variable "sourceMachineImageEncryptionKey" {
  description = "Source Machine Image Encryption Key"
  type = object({

    rawKey               = optional(string, null)
    rsaEncryptedKey      = optional(string, null)
    kmsKeyName           = optional(string, null)
    sha256               = optional(string, null)
    kmsKeyServiceAccount = optional(string, null)
  })
  default = null
}

variable "confidentialInstanceConfig" {
  description = "Confidential Instance Config"
  type = object({
    enableConfidentialCompute = optional(bool, null)
    confidentialInstanceType  = optional(string, null)
  })
}

#   "fingerprint": string,
variable "privateIpv6GoogleAccess" {
  description = ""
  type        = string
  default     = null
}

variable "advancedMachineFeatures" {
  description = "Advanced Machine Features"
  type = object({
    enableNestedVirtualization = optional(bool, null)
    threadsPerCore             = optional(number, null)
    visibleCoreCount           = optional(number, null)
    enableUefiNetworking       = optional(bool, null)
    performanceMonitoringUnit  = optional(string, null)
    turboMode                  = optional(string, null)
  })
  default = null
}

#   "lastStartTimestamp": string,
#   "lastStopTimestamp": string,
#   "lastSuspendedTimestamp": string,
#   "satisfiesPzs": boolean,
#   "satisfiesPzi": boolean,

variable "resourceStatus" {
  description = "Resource Status"
  type = object({
    scheduling = optional(object({
      availabilityDomain = optional(number, null)
    }), null)
    upcomingMaintenance = optional(object({
      type                  = optional(string, null)
      canReschedule         = optional(bool, null)
      windowStartTime       = optional(string, null)
      windowEndTime         = optional(string, null)
      latestWindowStartTime = optional(string, null)
      maintenanceStatus     = optional(string, null)
    }), null)
    physicalHost = optional(string, null)
  })
  default = null
}

variable "networkPerformanceConfig" {
  description = "Network Performance Config"
  type = object({
    totalEgressBandwidthTier = optional(string, null)
  })
  default = null
}

variable "keyRevocationActionType" {
  description = "Key Revocation Action Type"
  type        = string
  default     = null
}
