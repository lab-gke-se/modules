# Google Compute Disk Terraform Module
This module creates a google compute disk using the standard pattern that mirrors the google cloud apis. 

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_disk.disk](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_disk) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_accessMode"></a> [accessMode](#input\_accessMode) | n/a | `string` | `null` | no |
| <a name="input_architecture"></a> [architecture](#input\_architecture) | n/a | `string` | `null` | no |
| <a name="input_asyncPrimaryDisk"></a> [asyncPrimaryDisk](#input\_asyncPrimaryDisk) | n/a | <pre>object({<br/>    disk                     = optional(string, null)<br/>    diskId                   = optional(string, null)<br/>    consistencyGroupPolicy   = optional(string, null)<br/>    consistencyGroupPolicyId = optional(string, null)<br/>  })</pre> | `null` | no |
| <a name="input_asyncSecondaryDisks"></a> [asyncSecondaryDisks](#input\_asyncSecondaryDisks) | n/a | <pre>map(object({<br/>    disk                     = optional(string, null)<br/>    diskId                   = optional(string, null)<br/>    consistencyGroupPolicy   = optional(string, null)<br/>    consistencyGroupPolicyId = optional(string, null)<br/>  }))</pre> | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the disk | `string` | `null` | no |
| <a name="input_diskEncryptionKey"></a> [diskEncryptionKey](#input\_diskEncryptionKey) | n/a | <pre>object({<br/>    rawKey               = optional(string, null)<br/>    rsaEncryptedKey      = optional(string, null)<br/>    kmsKeyName           = optional(string, null)<br/>    sha256               = optional(string, null)<br/>    kmsKeyServiceAccount = optional(string, null)<br/>  })</pre> | `null` | no |
| <a name="input_enableConfidentialCompute"></a> [enableConfidentialCompute](#input\_enableConfidentialCompute) | n/a | `bool` | `null` | no |
| <a name="input_guestOsFeatures"></a> [guestOsFeatures](#input\_guestOsFeatures) | n/a | <pre>object({<br/>    type = optional(string, null)<br/>  })</pre> | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | n/a | `map(string)` | `null` | no |
| <a name="input_licenseCodes"></a> [licenseCodes](#input\_licenseCodes) | n/a | `list(string)` | `null` | no |
| <a name="input_licenses"></a> [licenses](#input\_licenses) | n/a | `list(string)` | `null` | no |
| <a name="input_locationHint"></a> [locationHint](#input\_locationHint) | n/a | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the disk | `string` | n/a | yes |
| <a name="input_options"></a> [options](#input\_options) | n/a | `string` | `null` | no |
| <a name="input_params"></a> [params](#input\_params) | n/a | <pre>object({<br/>    resourceManagerTags = optional(map(string), null)<br/>  })</pre> | `null` | no |
| <a name="input_physicalBlockSizeBytes"></a> [physicalBlockSizeBytes](#input\_physicalBlockSizeBytes) | n/a | `string` | `null` | no |
| <a name="input_project"></a> [project](#input\_project) | The project for the disk | `string` | n/a | yes |
| <a name="input_provisionedIops"></a> [provisionedIops](#input\_provisionedIops) | n/a | `string` | `null` | no |
| <a name="input_provisionedThroughput"></a> [provisionedThroughput](#input\_provisionedThroughput) | n/a | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `null` | no |
| <a name="input_replicaZones"></a> [replicaZones](#input\_replicaZones) | n/a | `list(string)` | `null` | no |
| <a name="input_resourcePolicies"></a> [resourcePolicies](#input\_resourcePolicies) | n/a | `list(string)` | `null` | no |
| <a name="input_resourceStatus"></a> [resourceStatus](#input\_resourceStatus) | n/a | <pre>object({<br/>    asyncPrimaryDisk = optional(object({<br/>      state = optional(string, null)<br/>    }))<br/>    asyncSecondaryDisk = optional(map(object({<br/>      state = optional(string, null)<br/>    })))<br/>  })</pre> | `null` | no |
| <a name="input_sizeGb"></a> [sizeGb](#input\_sizeGb) | The size of the disk in GB | `string` | `null` | no |
| <a name="input_sourceConsistencyGroupPolicy"></a> [sourceConsistencyGroupPolicy](#input\_sourceConsistencyGroupPolicy) | n/a | `string` | `null` | no |
| <a name="input_sourceConsistencyGroupPolicyId"></a> [sourceConsistencyGroupPolicyId](#input\_sourceConsistencyGroupPolicyId) | n/a | `string` | `null` | no |
| <a name="input_sourceDisk"></a> [sourceDisk](#input\_sourceDisk) | n/a | `string` | `null` | no |
| <a name="input_sourceDiskId"></a> [sourceDiskId](#input\_sourceDiskId) | n/a | `string` | `null` | no |
| <a name="input_sourceImage"></a> [sourceImage](#input\_sourceImage) | n/a | `string` | `null` | no |
| <a name="input_sourceImageEncryptionKey"></a> [sourceImageEncryptionKey](#input\_sourceImageEncryptionKey) | n/a | <pre>object({<br/>    rawKey               = optional(string, null)<br/>    rsaEncryptedKey      = optional(string, null)<br/>    kmsKeyName           = optional(string, null)<br/>    sha256               = optional(string, null)<br/>    kmsKeyServiceAccount = optional(string, null)<br/>  })</pre> | `null` | no |
| <a name="input_sourceInstantSnapshot"></a> [sourceInstantSnapshot](#input\_sourceInstantSnapshot) | n/a | `string` | `null` | no |
| <a name="input_sourceInstantSnapshotId"></a> [sourceInstantSnapshotId](#input\_sourceInstantSnapshotId) | n/a | `string` | `null` | no |
| <a name="input_sourceSnapshot"></a> [sourceSnapshot](#input\_sourceSnapshot) | n/a | `string` | `null` | no |
| <a name="input_sourceSnapshotEncryptionKey"></a> [sourceSnapshotEncryptionKey](#input\_sourceSnapshotEncryptionKey) | n/a | <pre>object({<br/>    rawKey               = optional(string, null)<br/>    rsaEncryptedKey      = optional(string, null)<br/>    kmsKeyName           = optional(string, null)<br/>    sha256               = optional(string, null)<br/>    kmsKeyServiceAccount = optional(string, null)<br/>  })</pre> | `null` | no |
| <a name="input_sourceStorageObject"></a> [sourceStorageObject](#input\_sourceStorageObject) | n/a | `string` | `null` | no |
| <a name="input_storagePool"></a> [storagePool](#input\_storagePool) | n/a | `string` | `null` | no |
| <a name="input_type"></a> [type](#input\_type) | The type of the disk | `string` | `null` | no |
| <a name="input_users"></a> [users](#input\_users) | n/a | `list(string)` | `null` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | The zone for the disk | `string` | `null` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->