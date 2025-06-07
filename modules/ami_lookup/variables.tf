variable "os_type" {
  description = "The OS type to lookup (e.g., ubuntu, redhat, suse)"
  type        = string
}

variable "architecture" {
  description = "Instance architecture (x86_64 or arm64)"
  type        = string
  default     = "x86_64"
}
