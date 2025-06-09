##############################
# Provider & Vault Settings  #
##############################

variable "region" {
  description = "AWS region to deploy resources (e.g., eu-west-1)"
  type        = string
}

variable "vault" {
  description = "Object describing Vault access (address, token, namespace)"
  type = object({
    address   = string
    token     = string
    namespace = string
  })
}

#######################
# Project & Tagging   #
#######################

variable "project" {
  description = "Project metadata (name, environment, owner)"
  type = object({
    name        = string
    environment = string
    owner       = string
  })
}

###########################
# Networking (VPC/IPAM)   #
###########################

variable "ipam" {
  description = "IPAM pool configuration"
  type = object({
    use_ipam      = bool
    pool_id       = string
    pool_cidr     = string
    netmask_len   = number
  })
  default = {
    use_ipam    = false
    pool_id     = null
    pool_cidr   = "10.0.0.0/8"
    netmask_len = 20
  }
}

variable "vpc" {
  description = "VPC and subnet configuration"
  type = object({
    cidr_block            = string
    enable_dns_hostnames  = bool
    enable_dns_support    = bool
    subnets               = map(object({
      az        = string
      type      = string
      vlan_tag  = string
      newbits   = number
    }))
  })
}

#######################
# Flow Logs           #
#######################

variable "flow_logs" {
  description = "VPC Flow Logs configuration"
  type = object({
    enabled      = bool
    iam_role_arn = string
    log_group_arn = string
    traffic_type = string
  })
  default = {
    enabled       = false
    iam_role_arn  = null
    log_group_arn = null
    traffic_type  = "ALL"
  }
}

######################
# Transit Gateway    #
######################

variable "transit_gateway" {
  description = "Transit Gateway configuration"
  type = object({
    asn         = number
    enable_multicast = bool
    routes      = list(object({
      destination_cidr = string
      attachment_id    = string
    }))
  })
  default = {
    asn            = 64512
    enable_multicast = false
    routes         = []
  }
}

#########################
# Compute/AMI           #
#########################

variable "ami" {
  description = "AMI and instance configuration"
  type = object({
    os_type       = string
    architecture  = string
    ami_id        = string
  })
  default = {
    os_type      = "ubuntu"
    architecture = "x86_64"
    ami_id       = null
  }
}

#######################
# Tagging             #
#######################

variable "extra_tags" {
  description = "Extra tags to merge with standard tags"
  type        = map(string)
  default     = {}
}

#######################
# Monitoring          #
#######################

variable "monitoring" {
  description = "Monitoring/logging parameters"
  type = object({
    log_retention_days = number
  })
  default = {
    log_retention_days = 14
  }
}
