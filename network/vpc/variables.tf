variable "project" {
  description = "The host project of the network"
  type        = string
}

variable "name" {
  description = "The name of the network"
  type        = string
}

variable "description" {
  description = "The description of the network"
  type        = string
  default     = null
}

variable "shared_vpc_host" {
  description = "Shared vpc host project"
  type        = bool
  default     = true
}

variable "routing_mode" {
  description = "The network routing mode"
  type        = string
  default     = "GLOBAL"
}

variable "delete_default_routes" {
  description = "Delete default routes on create"
  type        = bool
  default     = true
}

variable "mtu" {
  description = "The network MTU"
  type        = number
  default     = 0
}

variable "ipv6_internal_enable" {
  description = "Enabled Internal IPv6"
  type        = bool
  default     = false
}

variable "ipv6_internal_range" {
  description = "IPv6 range"
  type        = string
  default     = null
}

variable "network_firewall_policy_enforcement_order" {
  description = "The order to evaluate firewall policies and rules"
  type        = string
  default     = "AFTER_CLASSIC_FIREWALL"
}

