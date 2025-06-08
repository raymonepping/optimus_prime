output "vpc_flow_logs_role_arn" {
  value = aws_iam_role.vpc_flow_logs.arn
  description = "ARN for VPC Flow Logs IAM role"
}
