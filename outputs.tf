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
output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}
output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}
output "instance_id" {
  value = module.compute.instance_id
}
output "instance_public_ip" {
  value = module.compute.public_ip
}
