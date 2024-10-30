# Terraform variable, default to false in production environments
variable "force_destroy" {
  description = "Allows terraform to delete the bucket even if it isn't empty"
  type        = bool
  default     = true
}

variable "project" {
  description = "The project of the storage bucket"
  type        = string
}

# This is what the documentation says but it doesn't match the payload
# variable "encryption" {
#   description = "Encryption configuration for a bucket."
#   type = object({
#     defaultKmsKeyName = string
#   })
#   default = null
# }

variable "default_kms_key" {
  description = "Encryption configuration for a bucket."
  type        = string
  default     = null
}

# variable "iamConfiguration" {
#   description = "The IAM configuration for the bucket"
#   type = object({
#     publicAccessPrevention = string
#     uniformBucketLevelAccess = object({
#       enabled = bool
#     })
#   })
#   default = null
# }

variable "public_access_prevention" {
  description = ""
  type        = string
  default     = null
}

variable "uniform_bucket_level_access" {
  description = ""
  type        = bool
  default     = true
}

variable "labels" {
  type    = map(string)
  default = null
}

variable "location" {
  description = "The location of the storage bucket"
  type        = string
}

variable "logging" {
  description = "The bucket's logging configuration"
  type = object({
    logBucket       = string
    logObjectPrefix = string
  })
  default = null
}

variable "name" {
  description = "The name of the bucket"
  type        = string
}

variable "objectRetention" {
  type = object({
    mode = string
  })
  default = null
}

variable "retentionPolicy" {
  type = object({
    retentionPeriod = number
    isLocked        = bool
  })
  default = null
}

variable "softDeletePolicy" {
  type = object({
    retentionDurationSeconds = number
    effectiveTime            = optional(string, null)
  })
  default = null
}

# Payload doesn't match interface!
# variable "storageClass" {
#   description = "The bucket's default storage class"
#   type        = string
#   default     = null
# }

variable "default_storage_class" {
  description = "The bucket's default storage clasee"
  type        = string
  default     = null
}

# variable "versioning" {
#   description = "The bucket's versioning configuration"
#   type = object({
#     enabled = bool
#   })
#   default = null
# }

variable "versioning_enabled" {
  description = "The bucket's versioning configuration"
  type        = bool
  default     = null
}

# location: US-EAST4
# location_type: region


#   "defaultEventBasedHold": boolean,
#   "hierarchicalNamespace": {
#     "enabled": boolean
#   },
#   "acl": [
#     bucketAccessControls Resource
#   ],
#   "defaultObjectAcl": [
#     defaultObjectAccessControls Resource
#   ],
#   "website": {
#     "mainPageSuffix": string,
#     "notFoundPage": string
#   },
#   "owner": {
#     "entity": string,
#     "entityId": string
#   },
#   "cors": [
#     {
#       "origin": [
#         string
#       ],
#       "method": [
#         string
#       ],
#       "responseHeader": [
#         string
#       ],
#       "maxAgeSeconds": integer
#     }
#   ],
#   "lifecycle": {
#     "rule": [
#       {
#         "action": {
#           "storageClass": string,
#           "type": string
#         },
#         "condition": {
#           "age": integer,
#           "createdBefore": "date",
#           "isLive": boolean,
#           "numNewerVersions": integer,
#           "matchesStorageClass": [
#             string
#           ],
#           "daysSinceCustomTime": integer,
#           "customTimeBefore": "date",
#           "daysSinceNoncurrentTime": integer,
#           "noncurrentTimeBefore": "date",
#           "matchesPrefix": [
#             string
#           ],
#           "matchesSuffix": [
#             string
#           ]
#         }
#       }
#     ]
#   },
#   "autoclass": {
#     "enabled": boolean,
#     "toggleTime": "datetime",
#     "terminalStorageClass": string,
#     "terminalStorageClassUpdateTime": "datetime"
#   },
#   "billing": {
#     "requesterPays": boolean
#   },
#   "customPlacementConfig": {
#     "dataLocations": [
#       string,
#       string
#     ]
#   },
#   "rpo": string
# }
