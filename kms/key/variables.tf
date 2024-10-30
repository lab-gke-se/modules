variable "name" {
  description = "The name of the key"
  type        = string
}

variable "purpose" {
  description = "The immutable purpose for this CryptoKey"
  type        = string
  default     = null
}

variable "versionTemplate" {
  description = "A template describing settings for new CryptoKeyVersion instances"
  type = object({
    protectionLevel = optional(string, null)
    algorithm       = optional(string, null)
  })
  default = null
}

variable "labels" {
  description = "The labels to apply to the key"
  type        = map(string)
  default     = null
}

variable "importOnly" {
  description = "Whether this key may contain imported versions only"
  type        = bool
  default     = null
}

variable "destroyScheduledDuration" {
  description = "The period of time that versions of this key spend in the DESTROY_SCHEDULED state before transitioning to DESTROYED"
  type        = string
  default     = null
}

variable "cryptoKeyBackend" {
  description = " The resource name of the backend environment where the key material for all CryptoKeyVersions associated with this CryptoKey reside and where all related cryptographic operations are performed"
  type        = string
  default     = null
}

variable "keyAccessJustificationsPolicy" {
  description = "The policy used for Key Access Justifications Policy Enforcement"
  type = object({
    allowedAccessReasons = optional(list(string), null)
  })
  default = null
}

variable "nextRotationTime" {
  description = "At nextRotationTime, the Key Management Service will automatically create a new version and set it as primary"
  type        = string
  default     = null
}

variable "rotationPeriod" {
  description = "nextRotationTime will be advanced by this period when the service automatically rotates a key"
  type        = string
  default     = null
}
