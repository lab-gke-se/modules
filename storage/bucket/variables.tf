variable "name" {
  description = "The name of the storage bucket"
  type        = string
}

variable "project" {
  description = "The project of the storage bucket"
  type        = string
}

variable "location" {
  description = "The location of the storage bucket"
  type        = string
}

variable "data_classification" {
  description = "The classification for the data"
  type        = string
}

variable "kms_key_id" {
  description = "KMS key for CMEK encryption"
  type        = string
}

variable "versioning" {
  description = "Enable versioning"
  type        = bool
  default     = true
}

variable "log_bucket" {
  description = "Log bucket for logging"
  type        = string
  default     = null
}

variable "labels" {
  description = "Labels for the bucket"
  type        = map(string)
  default     = null
}

