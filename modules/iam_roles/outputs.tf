output "vpc_flow_logs_role_arn" {
  value = aws_iam_role.vpc_flow_logs.arn
  description = "ARN for VPC Flow Logs IAM role"
}

output "instance_role_name" {
  description = "Name of the instance IAM role"
  value       = aws_iam_role.instance.name
}

output "instance_profile_name" {
  description = "Name of the instance IAM profile"
  value       = aws_iam_instance_profile.instance.name
}
