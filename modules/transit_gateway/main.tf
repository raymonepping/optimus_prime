resource "aws_ec2_transit_gateway" "main" {
  description                      = "${var.project_name}-${var.environment} Transit Gateway"
  amazon_side_asn                  = var.tgw_asn
  dns_support                      = var.enable_dns_support ? "enable" : "disable"
  vpn_ecmp_support                 = "enable"
  default_route_table_association  = "disable"
  default_route_table_propagation  = "disable"
  multicast_support                = var.enable_multicast ? "enable" : "disable"
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-tgw"
    }
  )
}

resource "aws_ec2_transit_gateway_vpc_attachment" "main" {
  subnet_ids                                       = var.subnet_ids
  transit_gateway_id                               = aws_ec2_transit_gateway.main.id
  vpc_id                                           = var.vpc_id
  transit_gateway_default_route_table_association   = false
  transit_gateway_default_route_table_propagation   = false
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-tgw-vpc-attach"
    }
  )
}

resource "aws_ec2_transit_gateway_route_table" "main" {
  transit_gateway_id = aws_ec2_transit_gateway.main.id
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-tgw-rtb"
    }
  )
}

resource "aws_ec2_transit_gateway_route_table_association" "main" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.main.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.main.id
}

resource "aws_ec2_transit_gateway_route" "routes" {
  for_each = { for idx, route in var.tgw_routes : idx => route }
  destination_cidr_block         = each.value.destination_cidr
  transit_gateway_attachment_id  = each.value.attachment_id == "vpc" ? aws_ec2_transit_gateway_vpc_attachment.main.id : each.value.attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.main.id
}
