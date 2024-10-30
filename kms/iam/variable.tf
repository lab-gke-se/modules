variable "key_id" {
  description = ""
  type        = string
}

variable "services" {
  description = ""
  type        = list(string)
  default     = []
}

variable "encrypters" {
  description = ""
  type        = list(string)
  default     = []
}

variable "decrypters" {
  description = ""
  type        = list(string)
  default     = []
}
