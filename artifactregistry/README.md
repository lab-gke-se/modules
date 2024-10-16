# Artifact Registry Module
This module creates artiface registry repositories in google cloud

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
| [google_artifact_registry_repository.repository](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cleanupPolicies"></a> [cleanupPolicies](#input\_cleanupPolicies) | n/a | <pre>map(object({<br/>    id     = optional(string, null)<br/>    action = optional(string, null)<br/>    condition = optional(object({<br/>      tagPrefixes         = optional(list(string), null)<br/>      versionNamePrefixes = optional(list(string), null)<br/>      packageNamePrefixes = optional(list(string), null)<br/>      tagState            = optional(string, null)<br/>      olderThan           = optional(string, null)<br/>      newerThan           = optional(string, null)<br/>    }), null)<br/>    mostRecentVersions = optional(object({<br/>      packageNamePrefixes = optional(list(string), null)<br/>      keepCount           = optional(number, null)<br/>    }), null)<br/>  }))</pre> | `null` | no |
| <a name="input_cleanupPolicyDryRun"></a> [cleanupPolicyDryRun](#input\_cleanupPolicyDryRun) | n/a | `bool` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | n/a | `string` | `null` | no |
| <a name="input_disallowUnspecifiedMode"></a> [disallowUnspecifiedMode](#input\_disallowUnspecifiedMode) | n/a | `bool` | `null` | no |
| <a name="input_dockerConfig"></a> [dockerConfig](#input\_dockerConfig) | n/a | <pre>object({<br/>    immutableTags = optional(bool, null)<br/>  })</pre> | `null` | no |
| <a name="input_format"></a> [format](#input\_format) | n/a | `string` | n/a | yes |
| <a name="input_kmsKeyName"></a> [kmsKeyName](#input\_kmsKeyName) | n/a | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | n/a | `map(string)` | `null` | no |
| <a name="input_mavenConfig"></a> [mavenConfig](#input\_mavenConfig) | n/a | <pre>object({<br/>    allowSnapshotOverwrites = optional(bool, null)<br/>    versionPolicy           = optional(string, null)<br/>  })</pre> | `null` | no |
| <a name="input_mode"></a> [mode](#input\_mode) | n/a | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The project for the artifact registry | `string` | n/a | yes |
| <a name="input_remoteRepositoryConfig"></a> [remoteRepositoryConfig](#input\_remoteRepositoryConfig) | n/a | <pre>object({<br/>    description = optional(string, null)<br/>    upstreamCredentials = optional(object({<br/>      usernamePasswordCredentials = optional(object({<br/>        username              = optional(string, null)<br/>        passwordSecretVersion = optional(string, null)<br/>      }), null)<br/>    }), null)<br/>    disableUpstreamValidation = optional(bool, null),<br/>    dockerRepository = optional(object({<br/>      publicRepository = optional(string, null)<br/>      customRepository = optional(object({<br/>        uri = optional(string, null)<br/>      }), null)<br/>    }), null)<br/>    mavenRepository = optional(object({<br/>      publicRepository = optional(string, null)<br/>      customRepository = optional(object({<br/>        uri = optional(string, null)<br/>      }), null)<br/>    }), null)<br/>    npmRepository = optional(object({<br/>      publicRepository = optional(string, null)<br/>      customRepository = optional(object({<br/>        uri = optional(string, null)<br/>      }), null)<br/>    }), null)<br/>    pythonRepository = optional(object({<br/>      publicRepository = optional(string, null)<br/>      customRepository = optional(object({<br/>        uri = optional(string, null)<br/>      }), null)<br/>    }), null)<br/>    aptRepository = optional(object({<br/>      publicRepository = optional(object({<br/>        repositoryBase = optional(string, null)<br/>        repositoryPath = optional(string, null)<br/>      }), null)<br/>      customRepository = optional(object({<br/>        uri = optional(string, null)<br/>      }), null)<br/>    }), null)<br/>    yumRepository = optional(object({<br/>      publicRepository = optional(object({<br/>        repositoryBase = optional(string, null)<br/>        repositoryPath = optional(string, null)<br/>      }), null)<br/>      customRepository = optional(object({<br/>        uri = optional(string, null)<br/>      }), null)<br/>    }), null)<br/>  })</pre> | `null` | no |
| <a name="input_sizeBytes"></a> [sizeBytes](#input\_sizeBytes) | n/a | `string` | `null` | no |
| <a name="input_virtualRepositoryConfig"></a> [virtualRepositoryConfig](#input\_virtualRepositoryConfig) | n/a | <pre>object({<br/>    upstreamPolicies = optional(list(object({<br/>      id         = optional(string, null)<br/>      repository = optional(string, null)<br/>      priority   = optional(number, null)<br/>    })), null)<br/>  })</pre> | `null` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->