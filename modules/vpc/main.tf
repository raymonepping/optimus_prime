resource "aws_vpc" "main" {
  ipv4_ipam_pool_id   = var.use_ipam ? var.ipam_pool_id : null
  ipv4_netmask_length = var.use_ipam ? var.vpc_netmask_length : null
  cidr_block          = var.use_ipam ? null : var.vpc_cidr

  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-vpc"
    }
  )
}

data "aws_vpc" "main" {
  id         = aws_vpc.main.id
  depends_on = [aws_vpc.main]
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-igw"
    }
  )
}

resource "aws_subnet" "private" {
  count = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  availability_zone = var.availability_zones[count.index]
  cidr_block = cidrsubnet(
    data.aws_vpc.main.cidr_block,
    var.subnet_newbits != null ? var.subnet_newbits : 8,
    count.index
  )
  map_public_ip_on_launch = var.subnet_types[count.index] == "public" ? true : false
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-${var.subnet_types[count.index]}-subnet-${count.index + 1}",
      VLAN = var.vlan_tags[count.index],
      Type = var.subnet_types[count.index]
    }
  )
  depends_on = [data.aws_vpc.main]
}

resource "aws_route_table" "private" {
  count  = length([for k, v in var.subnet_types : k if v == "private"])
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-rt-private-${count.index + 1}"
    }
  )
}

resource "aws_route_table" "public" {
  count  = length([for k, v in var.subnet_types : k if v == "public"]) > 0 ? 1 : 0
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-rt-public"
    }
  )
}

resource "aws_route" "public_internet" {
  count                  = length([for k, v in var.subnet_types : k if v == "public"]) > 0 ? 1 : 0
  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "subnet" {
  count = length(var.availability_zones)
  subnet_id = aws_subnet.private[count.index].id
  route_table_id = var.subnet_types[count.index] == "public" ? (
    length(aws_route_table.public) > 0 ? aws_route_table.public[0].id : aws_route_table.private[0].id
  ) : element(aws_route_table.private[*].id, count.index)
}

resource "aws_flow_log" "vpc" {
  count = var.enable_flow_logs ? 1 : 0

  iam_role_arn    = var.flow_log_iam_role_arn
  log_group_name  = var.flow_log_log_group_name
  vpc_id          = aws_vpc.main.id
  traffic_type    = var.flow_log_traffic_type

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-vpc-flow-logs"
    }
  )
}