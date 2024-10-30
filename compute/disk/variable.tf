variable "project" {
  description = "The project for the disk"
  type        = string
}

variable "name" {
  description = "The name of the disk"
  type        = string
}

variable "description" {
  description = "The description of the disk"
  type        = string
  default     = null
}

variable "sizeGb" {
  description = "The size of the disk in GB"
  type        = string
  default     = null
}

variable "zone" {
  description = "The zone for the disk"
  type        = string
  default     = null
}

#   "status": enum,

variable "sourceSnapshot" {
  description = ""
  type        = string
  default     = null
}

#   "sourceSnapshotId": string,

variable "sourceStorageObject" {
  description = ""
  type        = string
  default     = null
}

variable "options" {
  description = ""
  type        = string
  default     = null
}

#   "selfLink": string,

variable "sourceImage" {
  description = ""
  type        = string
  default     = null
}

#   "sourceImageId": string,

variable "type" {
  description = "The type of the disk"
  type        = string
  default     = null
}

variable "licenses" {
  description = ""
  type        = list(string)
  default     = null
}

variable "guestOsFeatures" {
  description = ""
  type = list(object({
    type = optional(string, null)
  }))
  default = null
}

#   "lastAttachTimestamp": string,
#   "lastDetachTimestamp": string,

variable "users" {
  description = ""
  type        = list(string)
  default     = null
}

variable "diskEncryptionKey" {
  description = ""
  type = object({
    rawKey               = optional(string, null)
    rsaEncryptedKey      = optional(string, null)
    kmsKeyName           = optional(string, null)
    sha256               = optional(string, null)
    kmsKeyServiceAccount = optional(string, null)
  })
  default = null
}

variable "sourceImageEncryptionKey" {
  description = ""
  type = object({
    rawKey               = optional(string, null)
    rsaEncryptedKey      = optional(string, null)
    kmsKeyName           = optional(string, null)
    sha256               = optional(string, null)
    kmsKeyServiceAccount = optional(string, null)
  })
  default = null
}

variable "sourceSnapshotEncryptionKey" {
  description = ""
  type = object({
    rawKey               = optional(string, null)
    rsaEncryptedKey      = optional(string, null)
    kmsKeyName           = optional(string, null)
    sha256               = optional(string, null)
    kmsKeyServiceAccount = optional(string, null)
  })
  default = null
}

variable "labels" {
  description = ""
  type        = map(string)
  default     = null
}

#   "labelFingerprint": string,

variable "region" {
  description = ""
  type        = string
  default     = null
}

variable "replicaZones" {
  description = ""
  type        = list(string)
  default     = null
}

variable "licenseCodes" {
  description = ""
  type        = list(string)
  default     = null
}

variable "physicalBlockSizeBytes" {
  description = ""
  type        = string
  default     = null
}

variable "resourcePolicies" {
  description = ""
  type        = list(string)
  default     = null
}

variable "sourceDisk" {
  description = ""
  type        = string
  default     = null
}

variable "sourceDiskId" {
  description = ""
  type        = string
  default     = null
}

variable "provisionedIops" {
  description = ""
  type        = string
  default     = null
}

variable "provisionedThroughput" {
  description = ""
  type        = string
  default     = null
}

variable "enableConfidentialCompute" {
  description = ""
  type        = bool
  default     = null
}

variable "sourceInstantSnapshot" {
  description = ""
  type        = string
  default     = null
}

variable "sourceInstantSnapshotId" {
  description = ""
  type        = string
  default     = null
}

#   "satisfiesPzs": boolean,
#   "satisfiesPzi": boolean,

variable "locationHint" {
  description = ""
  type        = string
  default     = null
}

variable "storagePool" {
  description = ""
  type        = string
  default     = null
}

variable "accessMode" {
  description = ""
  type        = string
  default     = null
}

variable "asyncPrimaryDisk" {
  description = ""
  type = object({
    disk                     = optional(string, null)
    diskId                   = optional(string, null)
    consistencyGroupPolicy   = optional(string, null)
    consistencyGroupPolicyId = optional(string, null)
  })
  default = null
}

variable "asyncSecondaryDisks" {
  description = ""
  type = map(object({
    disk                     = optional(string, null)
    diskId                   = optional(string, null)
    consistencyGroupPolicy   = optional(string, null)
    consistencyGroupPolicyId = optional(string, null)
  }))
  default = null
}

variable "resourceStatus" {
  description = ""
  type = object({
    asyncPrimaryDisk = optional(object({
      state = optional(string, null)
    }))
    asyncSecondaryDisk = optional(map(object({
      state = optional(string, null)
    })))
  })
  default = null
}

variable "sourceConsistencyGroupPolicy" {
  description = ""
  type        = string
  default     = null
}

variable "sourceConsistencyGroupPolicyId" {
  description = ""
  type        = string
  default     = null
}

variable "architecture" {
  description = ""
  type        = string
  default     = null
}

variable "params" {
  description = ""
  type = object({
    resourceManagerTags = optional(map(string), null)
  })
  default = null
}
