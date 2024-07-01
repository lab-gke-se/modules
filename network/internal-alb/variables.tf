variable "project" {
  description = "The project containing the service"
  type        = string
}

variable "project_number" {
  description = "The project number of the project (required for compute.googleapis.com)"
  type        = string
  default     = null
}
