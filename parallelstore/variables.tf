variable "name" {
  description = ""
  type        = string
}

variable "capacityGib" {
  description = ""
  type        = string
}

variable "description" {
  description = ""
  type        = string
  default     = null
}

variable "labels" {
  description = ""
  type        = map(string)
  default     = null
}

variable "network" {
  description = ""
  type        = string
  default     = null
}

variable "reservedIpRange" {
  description = ""
  type        = string
  default     = null
}

variable "fileStripeLevel" {
  description = ""
  type        = string
  default     = null
}

variable "directoryStripeLevel" {
  description = ""
  type        = string
  default     = null
}
