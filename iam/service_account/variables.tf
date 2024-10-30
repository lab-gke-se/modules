variable "email" {
  description = "The service account email address"
  type        = string
}

variable "projectId" {
  description = "The service account project"
  type        = string
}

variable "displayName" {
  description = "The service account display name"
  type        = string
  default     = null
}

variable "description" {
  description = "The service account description"
  type        = string
  default     = null
}

variable "disabled" {
  description = "The service account disable status"
  type        = bool
  default     = false
}
