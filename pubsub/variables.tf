variable "project" {
  type = string
}

variable "name" {
  type = string
}

variable "labels" {
  type    = map(string)
  default = null
}

variable "messageStoragePolicy" {
  type = object({
    allowedPersistenceRegions = optional(list(string), null)
    enforceInTransit          = optional(bool, null)
  })
  default = null
}

variable "kmsKeyName" {
  type    = string
  default = null
}

variable "schemaSettings" {
  type = object({
    schema          = string
    encoding        = optional(string)
    firstRevisionId = optional(string, null)
    lastRevisionId  = optional(string, null)
  })
  default = null
}

#   "satisfiesPzs": boolean,

variable "messageRetentionDuration" {
  type    = string
  default = null
}

variable "ingestionDataSourceSettings" {
  type = object({
    awsKinesis = optional(object({
      state             = optional(string, null)
      streamArn         = optional(string, null)
      consumerArn       = optional(string, null)
      awsRoleArn        = optional(string, null)
      gcpServiceAccount = optional(string, null)
    }), null)
  })
  default = null
}
