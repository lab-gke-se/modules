variable "project" {
  description = "The project of the subnets"
  type        = string
}

variable "network" {
  description = "The network for the subnets"
  type        = string
}

variable "subnets" {
  description = "The subnets in the network"
  type = map(object({
    name                     = string
    ip_cidr_range            = string
    region                   = string
    private_ip_google_access = optional(string)
  }))
}

variable "secondary_ranges" {
  description = "Secondary ranges"
  type        = map(list(object({ range_name = string, ip_cidr_range = string })))
  default     = {}
}
