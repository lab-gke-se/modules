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
| [google_cloudfunctions_function.function](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions_function) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_automaticUpdatePolicy"></a> [automaticUpdatePolicy](#input\_automaticUpdatePolicy) | Security patches are applied automatically to the runtime without requiring the function to be redeployed. | `object({})` | `null` | no |
| <a name="input_availableMemoryMb"></a> [availableMemoryMb](#input\_availableMemoryMb) | The amount of memory in MB available for a function. Defaults to 256MB. | `number` | `null` | no |
| <a name="input_buildEnvironmentVariables"></a> [buildEnvironmentVariables](#input\_buildEnvironmentVariables) | Build environment variables that shall be available during build time. | `map(string)` | `null` | no |
| <a name="input_buildServiceAccount"></a> [buildServiceAccount](#input\_buildServiceAccount) | A service account the user provides for use with Cloud Build. | `string` | `null` | no |
| <a name="input_buildWorkerPool"></a> [buildWorkerPool](#input\_buildWorkerPool) | Name of the Cloud Build Custom Worker Pool that should be used to build the function. | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | User-provided description of the function. | `string` | `null` | no |
| <a name="input_dockerRegistry"></a> [dockerRegistry](#input\_dockerRegistry) | Docker Registry to use for this deployment. | `string` | `null` | no |
| <a name="input_dockerRepository"></a> [dockerRepository](#input\_dockerRepository) | User-managed repository created in Artifact Registry to which the function's Docker image will be pushed after it is built by Cloud Build. | `string` | `null` | no |
| <a name="input_entryPoint"></a> [entryPoint](#input\_entryPoint) | The name of the function (as defined in source code) that will be executed. Defaults to the resource name suffix (ID of the function), if not specified. | `string` | `null` | no |
| <a name="input_environmentVariables"></a> [environmentVariables](#input\_environmentVariables) | Environment variables that shall be available during function execution. | `map(string)` | `null` | no |
| <a name="input_eventTrigger"></a> [eventTrigger](#input\_eventTrigger) | A source that fires events in response to a condition in another service. | <pre>object({<br/>    eventType = string<br/>    resource  = string<br/>    service   = string<br/>    failurePolicy = optional(object({<br/>      retry = object({})<br/>    }), null)<br/>  })</pre> | `null` | no |
| <a name="input_httpsTrigger"></a> [httpsTrigger](#input\_httpsTrigger) | An HTTPS endpoint type of source that can be triggered via URL. | <pre>object({<br/>    securityLevel = string<br/>  })</pre> | `null` | no |
| <a name="input_ingressSettings"></a> [ingressSettings](#input\_ingressSettings) | The ingress settings for the function, controlling what traffic can reach it. | `string` | `null` | no |
| <a name="input_kmsKeyName"></a> [kmsKeyName](#input\_kmsKeyName) | Resource name of a KMS crypto key (managed by the user) used to encrypt/decrypt function resources. | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels associated with this Cloud Function. | `map(string)` | `null` | no |
| <a name="input_maxInstances"></a> [maxInstances](#input\_maxInstances) | The limit on the maximum number of function instances that may coexist at a given time. | `number` | `null` | no |
| <a name="input_minInstances"></a> [minInstances](#input\_minInstances) | A lower bound for the number function instances that may coexist at a given time. | `number` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | A user-defined name of the function | `string` | n/a | yes |
| <a name="input_onDeployUpdatePolicy"></a> [onDeployUpdatePolicy](#input\_onDeployUpdatePolicy) | Security patches are only applied when a function is redeployed. | <pre>object({<br/>    runtimeVersion = string<br/>  })</pre> | `null` | no |
| <a name="input_project"></a> [project](#input\_project) | The project in which the function is created | `string` | n/a | yes |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | The runtime in which to run the function. | `string` | `null` | no |
| <a name="input_secretEnvironmentVariables"></a> [secretEnvironmentVariables](#input\_secretEnvironmentVariables) | Secret environment variables configuration. | <pre>list(object({<br/>    key       = string<br/>    projectId = string<br/>    secret    = string<br/>    version   = string<br/>  }))</pre> | `null` | no |
| <a name="input_secretVolumes"></a> [secretVolumes](#input\_secretVolumes) | Secret volumes configuration. | <pre>list(object({<br/>    mountPath = string<br/>    projectId = string<br/>    secret    = string<br/>    versions = list(object({<br/>      version = string<br/>      path    = string<br/>    }))<br/>  }))</pre> | `null` | no |
| <a name="input_serviceAccountEmail"></a> [serviceAccountEmail](#input\_serviceAccountEmail) | The email of the function's service account. If empty, defaults to {projectId}@appspot.gserviceaccount.com. | `string` | `null` | no |
| <a name="input_sourceArchiveUrl"></a> [sourceArchiveUrl](#input\_sourceArchiveUrl) | The Google Cloud Storage URL, starting with gs://, pointing to the zip archive which contains the function. | `string` | `null` | no |
| <a name="input_sourceRepository"></a> [sourceRepository](#input\_sourceRepository) | The source repository where a function is hosted. | <pre>object({<br/>    url = string<br/>  })</pre> | `null` | no |
| <a name="input_sourceToken"></a> [sourceToken](#input\_sourceToken) | An identifier for Firebase function sources. Disclaimer: This field is only supported for Firebase function deployments. | `string` | `null` | no |
| <a name="input_sourceUploadUrl"></a> [sourceUploadUrl](#input\_sourceUploadUrl) | The Google Cloud Storage signed URL used for source uploading, generated by calling [google.cloud.functions.v1.GenerateUploadUrl]. | `string` | `null` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | The function execution timeout. Defaults to 60 seconds | `string` | `null` | no |
| <a name="input_vpcConnector"></a> [vpcConnector](#input\_vpcConnector) | The VPC Network Connector that this cloud function can connect to. | `string` | `null` | no |
| <a name="input_vpcConnectorEgressSettings"></a> [vpcConnectorEgressSettings](#input\_vpcConnectorEgressSettings) | The egress settings for the connector, controlling what traffic is diverted through it. | `string` | `null` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->