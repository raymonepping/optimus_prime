output "vpc_id" {
  value       = aws_vpc.main.id
  description = "ID of the VPC"
}

output "vpc_cidr_block" {
  value       = data.aws_vpc.main.cidr_block
  description = "CIDR block of the VPC"
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.main.id
  description = "ID of the Internet Gateway"
}

output "subnet_ids" {
  value       = aws_subnet.private[*].id
  description = "List of subnet IDs"
}

output "public_subnet_ids" {
  value = [
    for i, type in var.subnet_types :
    aws_subnet.private[i].id if type == "public"
  ]
  description = "List of public subnet IDs"
}

output "private_subnet_ids" {
  value = [
    for i, type in var.subnet_types :
    aws_subnet.private[i].id if type == "private"
  ]
  description = "List of private subnet IDs"
}

output "subnet_cidrs" {
  value       = aws_subnet.private[*].cidr_block
  description = "List of subnet CIDR blocks"
}

output "public_route_table_id" {
  value       = length(aws_route_table.public) > 0 ? aws_route_table.public[0].id : null
  description = "ID of the public route table"
}

output "private_route_table_ids" {
  value       = aws_route_table.private[*].id
  description = "List of private route table IDs"
}

output "availability_zones" {
  value       = var.availability_zones
  description = "List of availability zones used"
}

output "vpc_main_route_table_id" {
  value       = aws_vpc.main.main_route_table_id
  description = "ID of the main route table"
}

output "vpc_default_security_group_id" {
  value       = aws_vpc.main.default_security_group_id
  description = "ID of the default security group"
}
