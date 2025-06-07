output "aws_region" {
  description = "The AWS region used for deployment"
  value       = var.region
}

output "ami_id" {
  value = module.ami_lookup.ami_id
}

output "instance_id" {
  value = module.compute.instance_id
}

output "instance_public_ip" {
  value = module.compute.public_ip
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
