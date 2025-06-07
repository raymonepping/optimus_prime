output "ami_id" {
  value = var.ami_id_override != "" ? var.ami_id_override : (
    length(data.aws_ami.latest) > 0 ? data.aws_ami.latest[0].id : null
  )
  description = "The AMI ID to use for the specified OS and architecture"
}
