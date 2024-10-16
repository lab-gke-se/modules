# Note: name = project/{project}/locations/{location}/functions/{name}
variable "project" {
  description = "The project in which the function is created"
  type        = string
}

# variable "location" {
#   description = "The location in which the function is created"
#   type        = string
# }

variable "name" {
  description = "A user-defined name of the function"
  type        = string
}

variable "description" {
  description = "User-provided description of the function."
  type        = string
  default     = null
}

variable "entryPoint" {
  description = "The name of the function (as defined in source code) that will be executed. Defaults to the resource name suffix (ID of the function), if not specified."
  type        = string
  default     = null
}

variable "runtime" {
  description = "The runtime in which to run the function."
  type        = string
  default     = null
}

variable "timeout" {
  description = "The function execution timeout. Defaults to 60 seconds"
  type        = string
  default     = null
}

variable "availableMemoryMb" {
  description = "The amount of memory in MB available for a function. Defaults to 256MB."
  type        = number
  default     = null
}

variable "serviceAccountEmail" {
  description = "The email of the function's service account. If empty, defaults to {projectId}@appspot.gserviceaccount.com."
  type        = string
  default     = null
}

variable "labels" {
  description = "Labels associated with this Cloud Function."
  type        = map(string)
  default     = null
}

variable "environmentVariables" {
  description = "Environment variables that shall be available during function execution."
  type        = map(string)
  default     = null
}

variable "buildEnvironmentVariables" {
  description = "Build environment variables that shall be available during build time."
  type        = map(string)
  default     = null
}

# Depricated
# variable "network" {
#   type = string
# }

variable "maxInstances" {
  description = "The limit on the maximum number of function instances that may coexist at a given time."
  type        = number
  default     = null
}

variable "minInstances" {
  description = "A lower bound for the number function instances that may coexist at a given time."
  type        = number
  default     = null
}

variable "vpcConnector" {
  description = "The VPC Network Connector that this cloud function can connect to."
  type        = string
  default     = null
}

variable "vpcConnectorEgressSettings" {
  description = "The egress settings for the connector, controlling what traffic is diverted through it."
  type        = string
  default     = null
}

variable "ingressSettings" {
  description = "The ingress settings for the function, controlling what traffic can reach it."
  type        = string
  default     = null
}

variable "kmsKeyName" {
  description = "Resource name of a KMS crypto key (managed by the user) used to encrypt/decrypt function resources."
  type        = string
  default     = null
}

variable "buildWorkerPool" {
  description = "Name of the Cloud Build Custom Worker Pool that should be used to build the function."
  type        = string
  default     = null
}

variable "secretEnvironmentVariables" {
  description = "Secret environment variables configuration."
  type = list(object({
    key       = string
    projectId = string
    secret    = string
    version   = string
  }))
  default = null
}

variable "secretVolumes" {
  description = "Secret volumes configuration."
  type = list(object({
    mountPath = string
    projectId = string
    secret    = string
    versions = list(object({
      version = string
      path    = string
    }))
  }))
  default = null
}

variable "sourceToken" {
  description = "An identifier for Firebase function sources. Disclaimer: This field is only supported for Firebase function deployments."
  type        = string
  default     = null
}

variable "dockerRepository" {
  description = "User-managed repository created in Artifact Registry to which the function's Docker image will be pushed after it is built by Cloud Build."
  type        = string
  default     = null
}

variable "dockerRegistry" {
  description = "Docker Registry to use for this deployment."
  type        = string
  default     = null
}

variable "buildServiceAccount" {
  description = "A service account the user provides for use with Cloud Build."
  type        = string
  default     = null
}

#   // Union field source_code can be only one of the following:
variable "sourceArchiveUrl" {
  description = "The Google Cloud Storage URL, starting with gs://, pointing to the zip archive which contains the function."
  type        = string
  default     = null
}

variable "sourceRepository" {
  description = "The source repository where a function is hosted."
  type = object({
    url = string
  })
  default = null
}

variable "sourceUploadUrl" {
  description = "The Google Cloud Storage signed URL used for source uploading, generated by calling [google.cloud.functions.v1.GenerateUploadUrl]."
  type        = string
  default     = null
}
#   // End of list of possible types for union field source_code.

#   // Union field trigger can be only one of the following:
variable "httpsTrigger" {
  description = "An HTTPS endpoint type of source that can be triggered via URL."
  type = object({
    securityLevel = string
  })
  default = null
}

variable "eventTrigger" {
  description = "A source that fires events in response to a condition in another service."
  type = object({
    eventType = string
    resource  = string
    service   = string
    failurePolicy = optional(object({
      retry = object({})
    }), null)
  })
  default = null
}
#   // End of list of possible types for union field trigger.

#   // Union field runtime_update_policy can be only one of the following:
variable "automaticUpdatePolicy" {
  description = "Security patches are applied automatically to the runtime without requiring the function to be redeployed."
  type        = object({})
  default     = null
}

variable "onDeployUpdatePolicy" {
  description = "Security patches are only applied when a function is redeployed."
  type = object({
    runtimeVersion = string
  })
  default = null
}
#   // End of list of possible types for union field runtime_update_policy.
