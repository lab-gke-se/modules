variable "parent" {
  description = "The parent of the policies"
  type        = string
}

variable "policies" {
  description = "A list of policies"
  type = list(object({
    policy = object({
      name = string
      spec = object({
        inherit_from_parent = optional(bool)
        exists              = optional(bool)
        rules = list(object({
          enforce   = optional(bool)
          allow_all = optional(bool)
          deny_all  = optional(bool)
          values = optional(object({
            allowed_values = optional(list(string), null)
            denied_values  = optional(list(string), null)
          }), null)
        }))
      })
    })
  }))
}
