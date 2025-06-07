variable "ami_id" {
  description = "AMI ID to use for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t3.micro"
}

variable "common_tags" {
  description = "Map of common resource tags"
  type        = map(string)
}

variable "name" {
  description = "Name tag for the instance"
  type        = string
}

variable "subnet_id" {
  description = "The subnet in which to launch the instance"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID (used for security group rules, etc.)"
  type        = string
}
