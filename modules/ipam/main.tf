data "aws_region" "current" {}

resource "aws_vpc_ipam" "main" {
  description = "${var.project_name} IPAM"
  operating_regions {
    region_name = data.aws_region.current.name
  }
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-ipam"
    }
  )
}

resource "aws_vpc_ipam_pool" "main" {
  address_family = "ipv4"
  ipam_scope_id  = aws_vpc_ipam.main.private_default_scope_id
  description    = "${var.project_name} main pool"
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-ipam-pool"
      Type = "parent"
    }
  )
}

resource "aws_vpc_ipam_pool_cidr" "main" {
  ipam_pool_id = aws_vpc_ipam_pool.main.id
  cidr         = var.ipam_pool_cidr
  lifecycle {
    create_before_destroy = false
  }
}

resource "aws_vpc_ipam_pool" "vpc" {
  address_family                    = "ipv4"
  ipam_scope_id                     = aws_vpc_ipam.main.private_default_scope_id
  source_ipam_pool_id               = aws_vpc_ipam_pool.main.id
  locale                            = data.aws_region.current.name
  description                       = "${var.project_name} VPC pool"
  allocation_default_netmask_length = 20
  allocation_min_netmask_length     = 16
  allocation_max_netmask_length     = 24
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-vpc-pool"
      Type = "vpc"
    }
  )
  depends_on = [aws_vpc_ipam_pool_cidr.main]
}

resource "aws_vpc_ipam_pool_cidr" "vpc" {
  ipam_pool_id   = aws_vpc_ipam_pool.vpc.id
  netmask_length = 10
  depends_on     = [aws_vpc_ipam_pool_cidr.main]
  lifecycle {
    create_before_destroy = false
  }
}
