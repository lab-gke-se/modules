variable "project" {
  description = "The project for the role"
  type        = string
}

variable "role_id" {
  description = "The identifier of the role"
  type        = string
}

variable "title" {
  description = "The title of the role"
  type        = string
}

variable "description" {
  description = "The description of the role"
  type        = string
  default     = null
}

variable "permissions" {
  description = "The permissions for the role"
  type        = list(string)
}

variable "stage" {
  description = "The stage for the role"
  type        = string
}
