variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "use_ipam" {
  description = "Whether to use IPAM for VPC CIDR allocation"
  type        = bool
  default     = false
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
  validation {
    condition = alltrue([
      for type in var.subnet_types : contains(["public", "private"], type)
    ])
    error_message = "Subnet types must be either 'public' or 'private'."
  }
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

variable "flow_log_log_group_arn" {
  description = "ARN of the CloudWatch Log Group for VPC Flow Logs"
  type        = string
  default     = null
}

variable "flow_log_traffic_type" {
  description = "Traffic type for VPC Flow Logs (ALL, ACCEPT, REJECT)"
  type        = string
  default     = "ALL"
  validation {
    condition     = contains(["ALL", "ACCEPT", "REJECT"], var.flow_log_traffic_type)
    error_message = "Flow log traffic type must be ALL, ACCEPT, or REJECT."
  }
}

variable "flow_log_log_group_name" {
  description = "Name of the CloudWatch Log Group for VPC Flow Logs"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default     = {}
}
