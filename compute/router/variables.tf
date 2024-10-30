variable "project" {
  description = "Project for this router"
  type        = string
}

variable "name" {
  description = "Name of the resource"
  type        = string
}

variable "description" {
  description = "A description of this resource"
  type        = string
  default     = null
}

variable "region" {
  description = "The region for this router"
  type        = string
  default     = null
}

variable "network" {
  description = "URI of the network to which this router belongs"
  type        = string
  default     = null
}

variable "encryptedInterconnectRouter" {
  description = "Indicates if a router is dedicated for use with encrypted VLAN attachments (interconnectAttachments)"
  type        = bool
  default     = null
}

variable "bgp" {
  description = "BGP information specific to this router"
  type = object({
    asn              = optional(number, null)
    advertiseMode    = optional(string, null)
    advertisedGroups = optional(list(string), null)
    advertisedIpRanges = optional(object({
      range       = optional(string, null)
      description = optional(string, null)
    }), null)
    keepaliveInterval = optional(number, null)
    identifierRange   = optional(string, null)
  })
  default = null
}

# variable "interfaces" {
#   description = "Router interfaces"
#   type = list(object({
#     name                         = optional(string, null)
#     linkedVpnTunnel              = optional(string, null)
#     linkedInterconnectAttachment = optional(string, null)
#     ipRange                      = optional(string, null)
#     managementType               = optional(string, null)
#     privateIpAddress             = optional(string, null)
#     redundantInterface           = optional(string, null)
#     subnetwork                   = optional(string, null)
#     ipVersion                    = optional(string, null)
#   }))
#   default = null
# }

# variable "bgpPeers" {
#   description = "BGP information that must be configured into the routing stack to establish BGP peering"
#   type = list(object({
#     name                    = optional(string, null)
#     interfaceName           = optional(string, null)
#     ipAddress               = optional(string, null)
#     peerIpAddress           = optional(string, null)
#     peerAsn                 = optional(number, null)
#     advertisedRoutePriority = optional(number, null)
#     advertiseMode           = optional(string, null)
#     advertisedGroups        = optional(list(string), null)
#     advertisedIpRanges = optional(list(object({
#       range       = optional(string, null)
#       description = optional(string, null)
#     })), null)
#     managementType = optional(string, null)
#     enable         = optional(string, null)
#     bfd = optional(object({
#       sessionInitializationMode = optional(string, null)
#       minTransmitInterval       = optional(number, null)
#       minReceiveInterval        = optional(number, null)
#       multiplier                = optional(number, null)
#     }), null)
#     routerApplianceInstance    = optional(string, null)
#     enableIpv6                 = optional(bool, null)
#     ipv6NexthopAddress         = optional(string, null)
#     peerIpv6NexthopAddress     = optional(string, null)
#     md5AuthenticationKeyName   = optional(string, null)
#     customLearnedRoutePriority = optional(number, null)
#     customLearnedIpRanges = optional(list(object({
#       range = optional(string, null)
#     })), null)
#     enableIpv4             = optional(bool, null)
#     ipv4NexthopAddress     = optional(string, null)
#     peerIpv4NexthopAddress = optional(string, null)
#     exportPolicies         = optional(list(string), null)
#     importPolicies         = optional(list(string), null)
#   }))
#   default = null
# }

# variable "nats" {
#   description = "A list of NAT services created in this router"
#   type = list(object({
#     name                          = optional(string, null)
#     type                          = optional(string, null)
#     autoNetworkTier               = optional(string, null)
#     endpointTypes                 = optional(list(string), null)
#     sourceSubnetworkIpRangesToNat = optional(string, null)
#     subnetworks = optional(list(object({
#       name                  = optional(string, null)
#       sourceIpRangesToNat   = optional(list(string), null)
#       secondaryIpRangeNames = optional(list(string), null)
#     })), null)
#     natIps                       = optional(list(string), null)
#     drainNatIps                  = optional(list(string), null)
#     natIpAllocateOption          = optional(string, null)
#     minPortsPerVm                = optional(number, null)
#     maxPortsPerVm                = optional(number, null)
#     enableDynamicPortAllocation  = optional(bool, null)
#     udpIdleTimeoutSec            = optional(number, null)
#     icmpIdleTimeoutSec           = optional(number, null)
#     tcpEstablishedIdleTimeoutSec = optional(number, null)
#     tcpTransitoryIdleTimeoutSec  = optional(number, null)
#     tcpTimeWaitTimeoutSec        = optional(number, null)
#     logConfig = optional(object({
#       enable = optional(bool, null)
#       filter = optional(string, null)
#     }), null)
#     rules = optional(list(object({
#       ruleNumber  = optional(number, null)
#       description = optional(string, null)
#       match       = optional(string, null)
#       action = optional(object({
#         sourceNatActiveIps    = optional(list(string), null)
#         sourceNatDrainIps     = optional(list(string), null)
#         sourceNatActiveRanges = optional(list(string), null)
#         sourceNatDrainRanges  = optional(list(string), null)
#       }), null)
#     })), null)
#     enableEndpointIndependentMapping = optional(bool, null)
#   }))
#   default = null
# }

# variable "md5AuthenticationKeys" {
#   description = "Keys used for MD5 authentication"
#   type = list(object({
#     name = optional(string, null)
#     key  = optional(string, null)
#   }))
#   default = null
# }
