variable "project" {
  description = "The project for the resource"
  type        = string
}

variable "name" {
  description = "The name of the subscription"
  type        = string
}

variable "topic" {
  description = "The topic for the subscription"
  type        = string
}

variable "labels" {
  description = "The labels for the subscription"
  type        = map(string)
  default     = null
}

variable "ackDeadlineSeconds" {
  description = "The number of seconds to acknowledge delivery"
  type        = number
  default     = null
}

variable "enableExactlyOnceDelivery" {
  description = "Enable exactly once delivery"
  type        = bool
  default     = null
}

variable "retainAckedMessages" {
  type    = bool
  default = null
}

variable "messageRetentionDuration" {
  type    = string
  default = null
}

variable "enableMessageOrdering" {
  type    = bool
  default = null
}

variable "detached" {
  type    = bool
  default = null
}

variable "topicMessageRetentionDuration" {
  type    = string
  default = null
}

variable "state" {
  type    = string
  default = null
}

variable "filter" {
  type    = string
  default = null
}

variable "pushConfig" {
  type = object({
    pushEndpoint = optional(string, null)
    attributes   = optional(map(string), null)
    oidcToken = optional(object({
      serviceAccountEmail = optional(string, null)
      audience            = optional(string, null)
    }), null)
    pubsubWrapper = optional(object({}), null)
    noWrapper = optional(object({
      writeMetadata = optional(bool, null)
    }), null)
  })
  default = null
}

variable "bigqueryConfig" {
  type = object({
    table               = optional(string, null)
    useTopicSchema      = optional(bool, null)
    writeMetadata       = optional(bool, null)
    dropUnknownFields   = optional(bool, null)
    state               = optional(string, null)
    useTableSchema      = optional(bool, null)
    serviceAccountEmail = optional(string, null)
  })
  default = null
}

variable "cloudStorageConfig" {
  type = object({
    bucket                 = optional(string, null)
    filenamePrefix         = optional(string, null)
    filenameSuffix         = optional(string, null)
    filenameDatetimeFormat = optional(string, null)
    maxDuration            = optional(string, null)
    maxBytes               = optional(string, null)
    maxMessages            = optional(string, null)
    state                  = optional(string, null)
    serviceAccountEmail    = optional(string, null)
    textConfig             = optional(object({}), null)
    avroConfig = optional(object({
      writeMetadata  = optional(bool, null)
      useTopicSchema = optional(bool, null)
    }), null)
  })
  default = null
}

variable "expirationPolicy" {
  type = object({
    ttl = optional(string, null)
  })
  default = null
}

variable "deadLetterPolicy" {
  type = object({
    deadLetterTopic     = optional(string, null)
    maxDeliveryAttempts = optional(number, null)
  })
  default = null
}

variable "retryPolicy" {
  type = object({
    minimumBackoff = optional(string, null)
    maximumBackoff = optional(string, null)
  })
  default = null
}

variable "analyticsHubSubscriptionInfo" {
  type = object({
    listing      = optional(string, null)
    subscription = optional(string, null)
  })
  default = null
}

