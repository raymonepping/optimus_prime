# Provider & Environment
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

# Compute/AMI
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

# Project Identification
variable "project_name" {
  description = "Project name for tagging and naming resources"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, prod, staging)"
  type        = string
}

# VPC & Networking
variable "use_ipam" {
  description = "Whether to use AWS IPAM for CIDR assignment"
  type        = bool
}

variable "ipam_pool_id" {
  description = "IPAM pool ID for VPC allocation (required if use_ipam is true)"
  type        = string
  default     = null
}

variable "vpc_netmask_length" {
  description = "Netmask length for VPC when using IPAM (e.g., 20 for /20)"
  type        = number
  default     = 20
}

variable "vpc_cidr" {
  description = "CIDR block for VPC (used when not using IPAM)"
  type        = string
  default     = "10.0.0.0/16"
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "subnet_types" {
  description = "List of subnet types (public/private) corresponding to availability zones"
  type        = list(string)
}

variable "vlan_tags" {
  description = "List of VLAN tags for subnets"
  type        = list(string)
  default     = []
}

variable "subnet_newbits" {
  description = "Number of additional bits for subnet CIDR calculation"
  type        = number
  default     = null
}

# Flow Logs
variable "enable_flow_logs" {
  description = "Enable VPC Flow Logs"
  type        = bool
  default     = false
}

variable "flow_log_iam_role_arn" {
  description = "IAM role ARN for VPC Flow Logs"
  type        = string
  default     = null
}

variable "flow_log_destination" {
  description = "Destination for VPC Flow Logs (CloudWatch Logs group ARN or S3 bucket ARN)"
  type        = string
  default     = null
}

variable "flow_log_traffic_type" {
  description = "Traffic type for VPC Flow Logs (ALL, ACCEPT, REJECT)"
  type        = string
  default     = "ALL"
}

# Optional: Tags map (for merging in modules if needed)
variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default     = {}
}

variable "ipam_pool_cidr" {
  description = "CIDR block for the main IPAM pool"
  type        = string
  default     = "10.0.0.0/8"
}

variable "tgw_asn" {
  description = "BGP ASN for Transit Gateway"
  type        = number
  default     = 64512
}

variable "enable_multicast" {
  description = "Enable multicast support"
  type        = bool
  default     = false
}

variable "tgw_routes" {
  description = "List of routes for Transit Gateway"
  type = list(object({
    destination_cidr = string
    attachment_id    = string
  }))
  default = []
}
