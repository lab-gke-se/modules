variable "folder" {
  description = "The folder to bind the members to this role"
  type        = string
}

variable "role" {
  description = "The role to bind the members to the resource"
  type        = string
}

variable "members" {
  description = "A list of members to bind to the resource with the role"
  type        = list(string)
}
