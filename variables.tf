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
