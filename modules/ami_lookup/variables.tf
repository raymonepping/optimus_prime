variable "os_type" {
  description = "The OS type to lookup (e.g., ubuntu, redhat, suse)"
  type        = string
}

variable "architecture" {
  description = "Instance architecture (x86_64 or arm64)"
  type        = string
  default     = "x86_64"
}

variable "ami_id_override" {
  description = "Optionally specify an explicit AMI ID to use instead of doing a lookup"
  type        = string
  default     = ""
}
