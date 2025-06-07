output "aws_region" {
  description = "The AWS region used for deployment"
  value       = var.region
}

output "aws_account_id" {
  description = "AWS Account ID being used"
  value       = data.aws_caller_identity.current.account_id
}
