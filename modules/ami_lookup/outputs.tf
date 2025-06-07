output "ami_id" {
  value       = data.aws_ami.latest.id
  description = "The AMI ID of the latest image for the specified OS and architecture"
}
