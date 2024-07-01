variable "project" {
  description = "The project for the dns zone"
  type        = string
}

variable "name" {
  description = "The name for the dns zone"
  type        = string
}

variable "dns_name" {
  description = "The dns name for the dns zone"
  type        = string
}

variable "description" {
  description = "The description of the dns zone"
  type        = string
  default     = null
}

variable "labels" {
  description = "The labels for the dns zone"
  type        = map(string)
  default     = null
}

variable "visibility" {
  description = "The visibility of the dns zone"
  type        = string
  default     = "PRIVATE"
}

variable "private_visibility_config" {
  description = "The private visibility configuration for the dns zone"
  type = object({
    networks = list(object({
      networkUrl = string
    }))
  })
}
