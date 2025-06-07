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
