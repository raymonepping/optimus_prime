output "region" {
  description = "AWS region used for deployment"
  value       = var.region
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

output "instance_id" {
  description = "ID of the deployed EC2 instance"
  value       = module.compute.instance_id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = module.compute.public_ip
}

output "tgw_id" {
  description = "ID of the Transit Gateway"
  value       = module.transit_gateway.tgw_id
}

output "ipam_pool_id" {
  description = "ID of the IPAM pool"
  value       = module.ipam.vpc_ipam_pool_id
}

output "vpc_flow_logs_log_group_arn" {
  description = "ARN of the CloudWatch Log Group for VPC Flow Logs"
  value       = module.monitoring.vpc_flow_logs_log_group_arn
}

output "tags_used" {
  description = "The effective tags applied to all resources"
  value = merge(
    {
      Project     = var.project.name
      Environment = var.project.environment
      Owner       = var.project.owner
      ManagedBy   = "Terraform"
    },
    var.extra_tags
  )
}
