
module "ipam" {
  source        = "./modules/ipam"
  project_name  = var.project_name
  environment   = var.environment
  ipam_pool_cidr = var.ipam_pool_cidr    
  tags         = local.common_tags
}

module "iam_roles" {
  source       = "./modules/iam_roles"
  project_name = var.project_name
  environment  = var.environment
  tags         = local.common_tags
}

module "monitoring" {
  source           = "./modules/monitoring"
  project_name     = var.project_name
  environment      = var.environment
  log_retention_days = 14
  tags             = local.common_tags
}

module "vpc" {
  source                 = "./modules/vpc"
  project_name           = var.project_name
  environment            = var.environment
  use_ipam               = var.use_ipam
  ipam_pool_id           = module.ipam.vpc_ipam_pool_id
  vpc_netmask_length     = var.vpc_netmask_length
  vpc_cidr               = var.vpc_cidr
  enable_dns_hostnames   = var.enable_dns_hostnames
  enable_dns_support     = var.enable_dns_support
  availability_zones     = var.availability_zones
  subnet_types           = var.subnet_types
  vlan_tags              = var.vlan_tags
  subnet_newbits         = var.subnet_newbits
  enable_flow_logs       = var.enable_flow_logs
  flow_log_iam_role_arn  = module.monitoring.vpc_flow_logs_role_arn
  flow_log_log_group_arn = module.monitoring.vpc_flow_logs_log_group_arn
  flow_log_traffic_type  = var.flow_log_traffic_type
  tags                   = local.common_tags

  depends_on = [module.ipam]  
}

module "transit_gateway" {
  source             = "./modules/transit_gateway"
  project_name       = var.project_name
  environment        = var.environment
  tgw_asn            = var.tgw_asn
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.public_subnet_ids 
  enable_dns_support = var.enable_dns_support
  enable_multicast   = var.enable_multicast
  tgw_routes         = var.tgw_routes
  tags               = local.common_tags

  depends_on = [module.vpc]  
}

module "ami_lookup" {
  source          = "./modules/ami_lookup"
  os_type         = "ubuntu"
  architecture    = "x86_64"
  ami_id_override = "ami-05d3e0186c058c4dd"
}

module "compute" {
  source   = "./modules/compute"
  project_name       = var.project_name
  environment        = var.environment
  ami_id             = module.ami_lookup.ami_id
  key_name           = "demo-keypair-name" # 

  instances = [
    {
      name                  = "${var.project_name}-${var.environment}-web"
      instance_type         = "t3.micro"
      subnet_id             = module.vpc.public_subnet_ids[0]
      security_group_ids    = [module.vpc.vpc_default_security_group_id] 
      iam_role_name         = module.iam_roles.instance_role_name
      iam_instance_profile  = module.iam_roles.instance_profile_name
      user_data_file        = null 
      tags                  = local.common_tags
    }
  ]

  depends_on = [module.vpc]
}
