module "vpc" {
  source                 = "./modules/vpc"
  project_name           = var.project_name
  environment            = var.environment
  use_ipam               = var.use_ipam
  ipam_pool_id           = var.ipam_pool_id
  vpc_netmask_length     = var.vpc_netmask_length
  vpc_cidr               = var.vpc_cidr
  enable_dns_hostnames   = var.enable_dns_hostnames
  enable_dns_support     = var.enable_dns_support
  availability_zones     = var.availability_zones
  subnet_types           = var.subnet_types
  vlan_tags              = var.vlan_tags
  subnet_newbits         = var.subnet_newbits
  enable_flow_logs       = var.enable_flow_logs
  flow_log_iam_role_arn  = var.flow_log_iam_role_arn
  flow_log_destination   = var.flow_log_destination
  flow_log_traffic_type  = var.flow_log_traffic_type
  tags                   = local.common_tags
}

module "ipam" {
  source        = "./modules/ipam"
  project_name  = var.project_name
  environment   = var.environment
  ipam_pool_cidr = var.ipam_pool_cidr    # or set directly if you want
  tags         = local.common_tags
}

module "transit_gateway" {
  source             = "./modules/transit_gateway"
  project_name       = var.project_name
  environment        = var.environment
  tgw_asn            = var.tgw_asn
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.public_subnet_ids # or private_subnet_ids as needed
  enable_dns_support = var.enable_dns_support
  enable_multicast   = var.enable_multicast
  tgw_routes         = var.tgw_routes
  tags               = local.common_tags
}

module "ami_lookup" {
  source          = "./modules/ami_lookup"
  os_type         = "ubuntu"
  architecture    = "x86_64"
  ami_id_override = "ami-05d3e0186c058c4dd"
}

module "compute" {
  source      = "./modules/compute"
  ami_id      = module.ami_lookup.ami_id
  subnet_id   = module.vpc.public_subnet_ids[0]   # <-- pick public or private as needed
  vpc_id      = module.vpc.vpc_id
  name        = "${var.project_name}-${var.environment}-web"
  common_tags = local.common_tags
}
