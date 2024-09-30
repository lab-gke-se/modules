variable "project" {
  description = "The project for the artifact registry"
  type        = string
}

variable "name" {
  description = ""
  type        = string
}

variable "format" {
  description = ""
  type        = string
}

variable "description" {
  description = ""
  type        = string
  default     = null
}

variable "labels" {
  description = ""
  type        = map(string)
  default     = null
}

#   "createTime": string,
#   "updateTime": string,

variable "kmsKeyName" {
  description = ""
  type        = string
  default     = null
}

variable "mode" {
  description = ""
  type        = string
  default     = null
}

variable "cleanupPolicies" {
  description = ""
  type = map(object({
    id     = optional(string, null)
    action = optional(string, null)
    condition = optional(object({
      tagPrefixes         = optional(list(string), null)
      versionNamePrefixes = optional(list(string), null)
      packageNamePrefixes = optional(list(string), null)
      tagState            = optional(string, null)
      olderThan           = optional(string, null)
      newerThan           = optional(string, null)
    }), null)
    mostRecentVersions = optional(object({
      packageNamePrefixes = optional(list(string), null)
      keepCount           = optional(number, null)
    }), null)
  }))
  default = null
}

variable "sizeBytes" {
  description = ""
  type        = string
  default     = null
}

#   "satisfiesPzs": boolean,
#   "satisfiesPzi": boolean,

variable "cleanupPolicyDryRun" {
  description = ""
  type        = bool
  default     = null
}

variable "disallowUnspecifiedMode" {
  description = ""
  type        = bool
  default     = null
}

variable "mavenConfig" {
  description = ""
  type = object({
    allowSnapshotOverwrites = optional(bool, null)
    versionPolicy           = optional(string, null)
  })
  default = null
}

variable "dockerConfig" {
  description = ""
  type = object({
    immutableTags = optional(bool, null)
  })
  default = null
}

variable "virtualRepositoryConfig" {
  description = ""
  type = object({
    upstreamPolicies = optional(list(object({
      id         = optional(string, null)
      repository = optional(string, null)
      priority   = optional(number, null)
    })), null)
  })
  default = null
}

variable "remoteRepositoryConfig" {
  description = ""
  type = object({
    description = optional(string, null)
    upstreamCredentials = optional(object({
      usernamePasswordCredentials = optional(object({
        username              = optional(string, null)
        passwordSecretVersion = optional(string, null)
      }), null)
    }), null)
    disableUpstreamValidation = optional(bool, null),
    dockerRepository = optional(object({
      publicRepository = optional(string, null)
      customRepository = optional(object({
        uri = optional(string, null)
      }), null)
    }), null)
    mavenRepository = optional(object({
      publicRepository = optional(string, null)
      customRepository = optional(object({
        uri = optional(string, null)
      }), null)
    }), null)
    npmRepository = optional(object({
      publicRepository = optional(string, null)
      customRepository = optional(object({
        uri = optional(string, null)
      }), null)
    }), null)
    pythonRepository = optional(object({
      publicRepository = optional(string, null)
      customRepository = optional(object({
        uri = optional(string, null)
      }), null)
    }), null)
    aptRepository = optional(object({
      publicRepository = optional(object({
        repositoryBase = optional(string, null)
        repositoryPath = optional(string, null)
      }), null)
      customRepository = optional(object({
        uri = optional(string, null)
      }), null)
    }), null)
    yumRepository = optional(object({
      publicRepository = optional(object({
        repositoryBase = optional(string, null)
        repositoryPath = optional(string, null)
      }), null)
      customRepository = optional(object({
        uri = optional(string, null)
      }), null)
    }), null)
  })
  default = null
}
