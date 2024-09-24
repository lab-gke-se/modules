variable "project" {
  description = "The host project of the network"
  type        = string
}

variable "shared_vpc_host" {
  description = "Whether this is a shared vpc host"
  type        = bool
  default     = true
}

variable "delete_default_routes" {
  description = "Delete default routes on create"
  type        = bool
  default     = true
}

variable "name" {
  description = "The name of the vpc"
  type        = string
}

variable "description" {
  description = "The description of the vpc"
  type        = string
  default     = null
}

# variable "IPv4Range" {
#   description = "The IPv4 range for the vpc"
#   type        = string
#   default     = null
# }

# variable "gatewayIPv4" {
#   description = "The IPv4 gateway for the vpc"
#   type        = string
#   default     = null
# }

variable "autoCreateSubnetworks" {
  description = "Auto create the subnets in all regions"
  type        = bool
  default     = false
}

# variable "subnetworks" {
#   description = "The subnetworks in the vpc - output only"
#   type        = list(string)
#   default     = false
# }

# variable "peerings" {
#   description = "The peerings to the vpc with other vpcs"
#   type = object({
#     name                           = optional(string, null)
#     network                        = optional(string, null)
#     autoCreateRoutes               = optional(bool, null)
#     exportCustomRoutes             = optional(bool, null)
#     importCustomRoutes             = optional(bool, null)
#     exchangeSubnetRoutes           = optional(bool, null)
#     exportSubnetRoutesWithPublicIp = optional(bool, null)
#     importSubnetRoutesWithPublicIp = optional(bool, null)
#     peerMtu                        = optional(number, null)
#     stackType                      = optional(string, null)
#   })
#   default = null
# }

variable "routingConfig" {
  description = "The routing configuration of the vpc"
  type = object({
    routingMode = optional(string, null)
  })
  default = null
}

variable "mtu" {
  description = "The maximum transmission unit for the vpc"
  type        = number
  default     = null
}

# variable "firewallPolicy" {
#   description = "The firewall policy for the vpc"
#   type        = string
#   default     = null
# }

variable "networkFirewallPolicyEnforcementOrder" {
  description = "The network firewall policy enforcement order for the vpc"
  type        = string
  default     = null
}

variable "enableUlaInternalIpv6" {
  description = "Enable unique location address for IPv6 for the vpc"
  type        = bool
  default     = null
}

variable "internalIpv6Range" {
  description = "The internal IPv6 range for the vpc"
  type        = string
  default     = null
}
