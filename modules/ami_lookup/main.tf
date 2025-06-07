data "aws_ami" "debug" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/*24.04*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

output "debug_ami_id" {
  value = data.aws_ami.debug.id
}

output "debug_ami_name" {
  value = data.aws_ami.debug.name
}
