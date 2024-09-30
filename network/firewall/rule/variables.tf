variable "project" {
  description = "The project hosting the firewall rule"
  type        = string
}

variable "name" {
  description = "The name of the firewall rule"
  type        = string
}

variable "description" {
  description = "The description of the firewall rule"
  type        = string
  default     = null
}

variable "network" {
  description = "The network the firewall rule applies to"
  type        = string
}

variable "priority" {
  description = "The priority of the firewall rule"
  type        = number
  default     = null
}

variable "direction" {
  description = "The direction of the firewall rule"
  type        = string
  default     = null
}

variable "disabled" {
  description = "Set to true if the firewall rule is disabled"
  type        = bool
  default     = null
}

variable "logConfig" {
  description = "The log configuration for the firewall rule"
  default     = null
}

variable "sourceRanges" {
  description = "The source ranges for the firewall rule"
  type        = list(string)
  default     = null
}

variable "destinationRanges" {
  description = "The destination ranges for the firewall rule"
  type        = list(string)
  default     = null
}

variable "allowed" {
  description = "The allowed ports and protocols for the firewall rule"
  default     = null
}

variable "denied" {
  description = "The denied ports and protocols for the firewall rule"
  default     = null
}
