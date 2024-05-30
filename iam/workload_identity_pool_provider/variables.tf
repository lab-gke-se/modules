variable "project" {
  description = "The project for the workload identity pool provider"
  type        = string
}

variable "workload_identity_pool_id" {
  description = "The workload identity pool identity"
  type        = string
}

variable "workload_identity_pool_provider_id" {
  description = "The workload identity pool provider identity"
  type        = string
}

variable "display_name" {
  description = "The display name for the workload identity pool"
  type        = string
}

variable "description" {
  description = "The description fro the workload identity pool"
  type        = string
}
