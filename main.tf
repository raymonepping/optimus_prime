module "ami_lookup" {
  source       = "./modules/ami_lookup"
  os_type      = var.os_type         # Can be set as workspace variable!
  architecture = var.architecture    # Optional—uses default "x86_64" if unset
}

output "ami_id" {
  value = module.ami_lookup.ami_id
}
