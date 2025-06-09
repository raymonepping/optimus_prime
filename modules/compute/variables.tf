variable "environment" {
  description = "Environment name"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "instances" {
  description = "List of instance configurations"
  type = list(object({
    name                = string
    instance_type       = string
    subnet_id          = string
    security_group_ids = list(string)
    iam_role_name      = string
    user_data_file     = string
    tags               = map(string)
  }))
}

variable "ami_id" {
  description = "AMI ID for instances"
  type        = string
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
}

variable "root_volume_size" {
  description = "Size of root volume in GB"
  type        = number
  default     = 20
}

variable "assign_elastic_ips" {
  description = "Whether to assign Elastic IPs to instances"
  type        = bool
  default     = false
}

variable "elastic_ip_allocation_ids" {
  description = "List of existing Elastic IP allocation IDs to associate"
  type        = list(string)
  default     = []
}

variable "create_dns_records" {
  description = "Whether to create Route53 DNS records"
  type        = bool
  default     = false
}

variable "route53_zone_id" {
  description = "Route53 private hosted zone ID"
  type        = string
  default     = null
}

variable "route53_zone_name" {
  description = "Route53 private hosted zone name"
  type        = string
  default     = "internal"
}

variable "enable_monitoring" {
  description = "Whether to create CloudWatch alarms"
  type        = bool
  default     = true
}

variable "cpu_alarm_threshold" {
  description = "CPU utilization threshold for alarm"
  type        = number
  default     = 80
}

variable "alarm_actions" {
  description = "List of ARNs to notify when alarm triggers"
  type        = list(string)
  default     = []
}

variable "create_instance_profiles" {
  description = "Whether to create IAM instance profiles"
  type        = bool
  default     = false
}

variable "additional_volumes" {
  description = "List of additional EBS volumes to attach"
  type = list(object({
    instance_index = number
    device_name    = string
    size          = number
    type          = string
  }))
  default = []
}

variable "kms_key_id" {
  description = "KMS key ID for EBS encryption"
  type        = string
  default     = null
}

variable "instances" {
  description = "List of instance configurations"
  type = list(object({
    name                    = string
    instance_type           = string
    subnet_id               = string
    security_group_ids      = list(string)
    iam_role_name           = string
    iam_instance_profile    = string    
    user_data_file          = string
    tags                    = map(string)
  }))
}
