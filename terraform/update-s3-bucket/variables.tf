variable "regions" {
  type        = list(string)
  description = "List of AWS regions"
}

variable "environment" {
  type        = string
  description = "Environment"
}

variable "cors_enabled" {
  type        = bool
  description = "Enable CORS"
  default     = false
}
