variable "region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "vault_address" {
  description = "The URL endpoint for the Vault cluster"
  type        = string
}

variable "vault_token" {
  description = "The Vault access token"
  type        = string
  sensitive   = true
}

variable "vault_namespace" {
  description = "The Vault namespace (for HCP Vault this is usually 'admin')"
  type        = string
  default     = "admin"
}

variable "os_type" {
  description = "The operating system to use (ubuntu, redhat, suse)"
  type        = string
  default     = "ubuntu"
}

variable "architecture" {
  description = "The CPU architecture (x86_64 or arm64)"
  type        = string
  default     = "x86_64"
}
