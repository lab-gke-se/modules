variable "project_id" {
  description = "The ID of the project in which the resource belongs."
  type        = string
}

variable "region" {
  description = "The region in which the cluster master will be created."
  type        = string
}

variable "gke_master_ipv4_cidr_block" {
  description = "The CIDR block for the GKE master."
  type        = string
}

variable "authorized_source_ranges" {
  description = "The list of authorized source ranges for the master."
  type        = list(string)
}

variable "service_accounts" {
  description = "List of service accounts to be used by the cluster."
  type = list(object({
    name  = string
    email = string
  }))
}

variable "subnetworks" {
  description = "List of subnetworks to be used by the cluster."
  type = list(object({
    name      = string
    self_link = string
  }))
}

variable "cluster_name" {
  description = "The full name of the cluster."
  type        = string
}