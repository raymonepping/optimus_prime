module "ami_lookup" {
  source      = "./modules/ami_lookup"
  os_type     = var.os_type
  architecture = var.architecture
}

output "latest_ami" {
  value = module.ami_lookup.ami_id
}
