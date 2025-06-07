module "ami_lookup" {
  source          = "./modules/ami_lookup"
  os_type         = "ubuntu"
  architecture    = "x86_64"
  ami_id_override = "ami-05d3e0186c058c4dd"
}

module "compute" {
  source      = "./modules/compute"
  ami_id      = module.ami_lookup.ami_id
  name        = "${var.project_name}-${var.environment}-web"
  common_tags = local.common_tags

}
