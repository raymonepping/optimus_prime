# Instance IDs
output "instance_ids" {
  description = "List of IDs of instances"
  value       = aws_instance.main[*].id
}

# Instance ARNs
output "instance_arns" {
  description = "List of ARNs of instances"
  value       = aws_instance.main[*].arn
}

# Private IP addresses
output "private_ips" {
  description = "List of private IP addresses assigned to the instances"
  value       = aws_instance.main[*].private_ip
}

# Public IP addresses
output "public_ips" {
  description = "List of public IP addresses assigned to the instances"
  value       = var.assign_elastic_ips ? aws_eip.main[*].public_ip : aws_instance.main[*].public_ip
}

# Private DNS names
output "private_dns" {
  description = "List of private DNS names assigned to the instances"
  value       = aws_instance.main[*].private_dns
}

# Public DNS names
output "public_dns" {
  description = "List of public DNS names assigned to the instances"
  value       = var.assign_elastic_ips ? aws_eip.main[*].public_dns : aws_instance.main[*].public_dns
}

# Instance states
output "instance_states" {
  description = "List of instance states"
  value       = aws_instance.main[*].instance_state
}

# Availability zones
output "availability_zones" {
  description = "List of availability zones of instances"
  value       = aws_instance.main[*].availability_zone
}

# Subnet IDs
output "subnet_ids" {
  description = "List of subnet IDs of instances"
  value       = aws_instance.main[*].subnet_id
}

# Security group IDs
output "security_groups" {
  description = "List of security groups of instances"
  value       = aws_instance.main[*].vpc_security_group_ids
}

# Key names
output "key_names" {
  description = "List of key names of instances"
  value       = aws_instance.main[*].key_name
}

# Instance profiles
output "iam_instance_profiles" {
  description = "List of IAM instance profiles associated with the instances"
  value       = aws_instance.main[*].iam_instance_profile
}

# Map of instance IDs to private IPs
output "instance_ip_map" {
  description = "Map of instance IDs to private IP addresses"
  value = zipmap(
    aws_instance.main[*].id,
    aws_instance.main[*].private_ip
  )
}

# Map of instance names to IDs
output "instance_name_id_map" {
  description = "Map of instance names to instance IDs"
  value = zipmap(
    [for inst in var.instances : inst.name],
    aws_instance.main[*].id
  )
}

# Elastic IP allocation IDs
output "eip_allocation_ids" {
  description = "List of allocation IDs of Elastic IPs"
  value       = var.assign_elastic_ips ? aws_eip.main[*].allocation_id : []
}

# Elastic IP addresses
output "eip_addresses" {
  description = "List of Elastic IP addresses"
  value       = var.assign_elastic_ips ? aws_eip.main[*].public_ip : []
}

# Route53 record FQDNs
output "route53_fqdns_private" {
  description = "List of FQDNs of Route53 records for private IPs"
  value       = var.create_dns_records && var.route53_zone_id != null ? aws_route53_record.private[*].fqdn : []
}

output "route53_fqdns_public" {
  description = "List of FQDNs of Route53 records for public IPs"
  value       = var.create_dns_records && var.route53_zone_id != null && var.assign_elastic_ips ? aws_route53_record.public[*].fqdn : []
}

# CloudWatch alarm names
output "cloudwatch_alarm_names" {
  description = "List of CloudWatch alarm names"
  value = var.enable_monitoring ? concat(
    aws_cloudwatch_metric_alarm.cpu_high[*].alarm_name,
    aws_cloudwatch_metric_alarm.status_check_failed[*].alarm_name
  ) : []
}

# Additional volume IDs
output "additional_volume_ids" {
  description = "Map of additional EBS volume IDs"
  value       = { for k, v in aws_ebs_volume.additional : k => v.id }
}

# Complete instance details
output "instance_details" {
  description = "Complete details of all instances"
  value = [
    for i, instance in aws_instance.main : {
      id                 = instance.id
      name               = var.instances[i].name
      type               = instance.instance_type
      state              = instance.instance_state
      private_ip         = instance.private_ip
      public_ip          = var.assign_elastic_ips ? aws_eip.main[i].public_ip : instance.public_ip
      availability_zone  = instance.availability_zone
      subnet_id          = instance.subnet_id
      security_group_ids = instance.vpc_security_group_ids
      key_name           = instance.key_name
      iam_profile        = instance.iam_instance_profile
    }
  ]
}