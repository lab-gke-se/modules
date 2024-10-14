variable "project" {
  description = "The project of the subnetwork"
  type        = string
}

variable "network" {
  description = "The network for the subnetwork"
  type        = string
}

variable "name" {
  description = "The name of the subnetwork"
  type        = string
}

variable "description" {
  description = "The description of the subnetwork"
  type        = string
  default     = null
}

variable "ipCidrRange" {
  description = "The IP CIDR range for the subnetwork"
  type        = string
  default     = null
}

variable "reservedInternalRange" {
  description = "The reserved internal range for the subnetwork"
  type        = string
  default     = null
}

variable "region" {
  description = "The region for the subnetwork"
  type        = string
  default     = null
}

variable "privateIpGoogleAccess" {
  description = "Whether private IPv4 google access is enabled for the subnetwork"
  type        = bool
  default     = null
}

variable "secondaryIpRanges" {
  description = "Secondary IP ranges"
  type = list(object({
    rangeName             = optional(string, null)
    ipCidrRange           = optional(string, null)
    reservedInternalRange = optional(string, null)
  }))
  default = null
}

# variable "enableFlowLogs" {
#   description = "Whether vpc flow logs are enabled for the subnetwork"
#   type        = bool
#   default     = null
# }

variable "privateIpv6GoogleAccess" {
  description = "Whether private IPv6 google access is enabled for this subnetwork"
  type        = string
  default     = null
}

#   "ipv6CidrRange": string,

variable "externalIpv6Prefix" {
  description = "The external IPv6 prefix for the subnetwork"
  type        = string
  default     = null
}

#   "internalIpv6Prefix": string,

variable "purpose" {
  description = "The purpose of the subnetwork"
  type        = string
  default     = null
}

variable "role" {
  description = "The role of the subnetwork"
  type        = string
  default     = null
}

variable "logConfig" {
  description = "The vpc flow log configuration for the subnetwork"
  type = object({
    enable              = optional(bool, null)
    aggregationInterval = optional(string, null)
    flowSampling        = optional(number, null)
    metadata            = optional(string, null)
    metadataFields      = optional(list(string), null)
    filterExpr          = optional(string, null)
  })
  default = null
}

variable "stackType" {
  description = "The stack type of the subnetwork"
  type        = string
  default     = null
}

variable "ipv6AccessType" {
  description = "The ipv6 acccess type of the subnetwork"
  type        = string
  default     = null
}
