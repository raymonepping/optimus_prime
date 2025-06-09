output "aws_region" {
  description = "The AWS region used for deployment"
  value       = var.region
}

output "ami_id" {
  value = module.ami_lookup.ami_id
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}

output "internet_gateway_id" {
  value = module.vpc.internet_gateway_id
}

output "subnet_ids" {
  value = module.vpc.subnet_ids
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "subnet_cidrs" {
  value = module.vpc.subnet_cidrs
}

output "public_route_table_id" {
  value = module.vpc.public_route_table_id
}

output "private_route_table_ids" {
  value = module.vpc.private_route_table_ids
}

output "availability_zones" {
  value = module.vpc.availability_zones
}

output "vpc_main_route_table_id" {
  value = module.vpc.vpc_main_route_table_id
}

output "vpc_default_security_group_id" {
  value = module.vpc.vpc_default_security_group_id
}

output "ipam_id" {
  value = module.ipam.ipam_id
}

output "main_pool_id" {
  value = module.ipam.main_pool_id
}

output "main_pool_cidr" {
  value = module.ipam.main_pool_cidr
}

output "vpc_ipam_pool_id" {
  value = module.ipam.vpc_ipam_pool_id
}

output "vpc_ipam_pool_cidr" {
  value = module.ipam.vpc_ipam_pool_cidr
}

output "tgw_id" {
  value = module.transit_gateway.tgw_id
}
output "tgw_arn" {
  value = module.transit_gateway.tgw_arn
}
output "tgw_route_table_id" {
  value = module.transit_gateway.tgw_route_table_id
}
output "tgw_attachment_id" {
  value = module.transit_gateway.tgw_attachment_id
}

output "instance_ids" {
  value = module.compute.instance_ids
  description = "List of IDs of all EC2 instances created by the compute module"
}

output "instance_public_ips" {
  value = module.compute.public_ips
  description = "List of public IPs of all EC2 instances created by the compute module"
}
