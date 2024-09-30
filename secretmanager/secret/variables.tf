variable "project" {
  description = "The project for the secret"
  type        = string
}

# Note: this is an output only field but overloaded for the secret id
variable "name" {
  description = "The name of the secret"
  type        = string
}

variable "replication" {
  description = "The replication policy of the secret data attached to the Secret."
  type = object({
    automatic = optional(object({
      customerManagedEncryption = optional(object({
        kmsKeyName = optional(string, null)
      }), null)
    }), null)
    userManaged = optional(object({
      replicas = optional(list(object({
        location = optional(string, null)
        customerManagedEncryption = optional(object({
          kmsKeyName = optional(string, null)
        }), null)
      })), null)
    }), null)
  })
  default = null
}

variable "labels" {
  description = "The labels assigned to this Secret."
  type        = map(string)
  default     = null
}

variable "topics" {
  description = "A Pub/Sub topic which Secret Manager will publish to when control plane events occur on this secret."
  type = list(object({
    name = optional(string, null)
  }))
  default = null
}

variable "rotation" {
  description = "Rotation policy attached to the Secret."
  type = object({
    nextRotationTime = optional(string, null)
    rotationPeriod   = optional(string, null)
  })
  default = null
}

variable "versionAliases" {
  description = "Mapping from version alias to version name."
  type        = map(string)
  default     = null
}

variable "annotations" {
  description = "Custom metadata about the secret."
  type        = map(string)
  default     = null
}

variable "expireTime" {
  description = "Timestamp in UTC when the Secret is scheduled to expire."
  type        = string
  default     = null
}

variable "ttl" {
  description = "The TTL for the Secret."
  type        = string
  default     = null
}
