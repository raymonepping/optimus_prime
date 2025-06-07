module "ami_lookup" {
  source          = "./modules/ami_lookup"
  os_type         = "ubuntu"
  architecture    = "x86_64"
  ami_id_override = "ami-05d3e0186c058c4dd"
}

output "ami_id" {
  value = module.ami_lookup.ami_id
}
