module "ami_lookup" {
  source      = "./modules/ami_lookup"
  os_type     = "ubuntu"
  architecture = "x86_64"  # or "arm64"
}

output "ami_id" {
  value = module.ami_lookup.ami_id
}
