variable "name" {
  description = "The name of the key"
  type        = string
}

variable "project" {
  description = "The project containing the service"
  type        = string
}

variable "project_number" {
  description = "The project number of the project (required for compute.googleapis.com)"
  type        = string
  default     = null
}

variable "services" {
  description = "A list of services that will use the key"
  type        = list(string)
  default     = []
}

variable "encrypters" {
  description = "A list of principals that are allowed to encrypt using this key"
  type        = list(string)
  default     = []
}

variable "decrypters" {
  description = "A list of principals that are allowed to decrypt using this key"
  type        = list(string)
  default     = []
}

variable "prevent_destroy" {
  description = "Prevent the destruction of the key?"
  type        = bool
  default     = false
}

variable "rotation_period" {
  description = "The rotation period for the key"
  type        = string
  default     = null
}

variable "destroy_scheduled_duration" {
  description = "The destroy scheduled duration for the key"
  type        = string
  default     = null
}

variable "key_ring" {
  description = "The key ring identifier"
  type        = string
}

variable "purpose" {
  description = "The purpose of the key"
  type        = string
  default     = null
}

variable "algorithm" {
  description = "The algorithm for the key"
  type        = string
  default     = "GOOGLE_SYMMETRIC_ENCRYPTION"
}

variable "protection_level" {
  description = "The algorithm for the key"
  type        = string
  default     = "HSM"
}

variable "labels" {
  description = "The labels to apply to the key"
  type        = map(string)
  default     = null
}

