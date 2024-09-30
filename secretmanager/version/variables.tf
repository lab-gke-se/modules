variable "secret" {
  description = "The secret for this version"
  type        = string
}

variable "secretData" {
  description = "The secret data"
  type        = string
}

variable "enabled" {
  description = "Is the version enabled"
  type        = bool
  default     = null
}

variable "deletion_policy" {
  description = "The deletion policy"
  type        = string
  default     = null
}

variable "is_secret_data_base64" {
  description = "Is the secret data base64 encoded?"
  type        = bool
  default     = null
}
