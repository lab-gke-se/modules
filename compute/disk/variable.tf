#   "kind": string,
#   "id": string,
#   "creationTimestamp": string,

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
#   "sourceSnapshot": string,
#   "sourceSnapshotId": string,
#   "sourceStorageObject": string,
#   "options": string,
#   "selfLink": string,
#   "sourceImage": string,
#   "sourceImageId": string,

variable "type" {
  description = "The type of the disk"
  type        = string
  default     = null
}

#   "licenses": [
#     string
#   ],
#   "guestOsFeatures": [
#     {
#       "type": enum
#     }
#   ],
#   "lastAttachTimestamp": string,
#   "lastDetachTimestamp": string,
#   "users": [
#     string
#   ],
#   "diskEncryptionKey": {
#     "rawKey": string,
#     "rsaEncryptedKey": string,
#     "kmsKeyName": string,
#     "sha256": string,
#     "kmsKeyServiceAccount": string
#   },
#   "sourceImageEncryptionKey": {
#     "rawKey": string,
#     "rsaEncryptedKey": string,
#     "kmsKeyName": string,
#     "sha256": string,
#     "kmsKeyServiceAccount": string
#   },
#   "sourceSnapshotEncryptionKey": {
#     "rawKey": string,
#     "rsaEncryptedKey": string,
#     "kmsKeyName": string,
#     "sha256": string,
#     "kmsKeyServiceAccount": string
#   },
#   "labels": {
#     string: string,
#     ...
#   },
#   "labelFingerprint": string,
#   "region": string,
#   "replicaZones": [
#     string
#   ],
#   "licenseCodes": [
#     string
#   ],
#   "physicalBlockSizeBytes": string,
#   "resourcePolicies": [
#     string
#   ],
#   "sourceDisk": string,
#   "sourceDiskId": string,
#   "provisionedIops": string,
#   "provisionedThroughput": string,
#   "enableConfidentialCompute": boolean,
#   "sourceInstantSnapshot": string,
#   "sourceInstantSnapshotId": string,
#   "satisfiesPzs": boolean,
#   "satisfiesPzi": boolean,
#   "locationHint": string,
#   "storagePool": string,
#   "accessMode": enum,
#   "asyncPrimaryDisk": {
#     "disk": string,
#     "diskId": string,
#     "consistencyGroupPolicy": string,
#     "consistencyGroupPolicyId": string
#   },
#   "asyncSecondaryDisks": {
#     string: {
#       "asyncReplicationDisk": {
#         "disk": string,
#         "diskId": string,
#         "consistencyGroupPolicy": string,
#         "consistencyGroupPolicyId": string
#       }
#     },
#     ...
#   },
#   "resourceStatus": {
#     "asyncPrimaryDisk": {
#       "state": enum
#     },
#     "asyncSecondaryDisks": {
#       string: {
#         "state": enum
#       },
#       ...
#     }
#   },
#   "sourceConsistencyGroupPolicy": string,
#   "sourceConsistencyGroupPolicyId": string,
#   "architecture": enum,
#   "params": {
#     "resourceManagerTags": {
#       string: string,
#       ...
#     }
#   }
# }
