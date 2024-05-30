variable "name" {
  description = "The service account name"
  type        = string
}

variable "project" {
  description = "The service account project"
  type        = string
}

variable "display_name" {
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
