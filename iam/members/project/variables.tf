variable "project" {
  description = "The project to bind the members to this role"
  type        = string
}

variable "iamPolicy" {
  description = "The role to bind the members to the resource"
  type = object({
    bindings = optional(list(object({
      role    = string
      members = list(string)
    })), null)
  })
}
