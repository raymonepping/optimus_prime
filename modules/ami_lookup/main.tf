locals {
  os_filters = {
    ubuntu = {
      name   = "ubuntu/images/hvm-ssd/ubuntu-noble-24.04-amd64-server-*"
      owners = ["099720109477"]
    }
    redhat = {
      name   = "RHEL-9*_HVM-*-x86_64-*"
      owners = ["309956199498"]
    }
    suse = {
      name   = "suse-sles-15-sp5-v202*-x86_64*"
      owners = ["013907871322"]
    }
  }
}

data "aws_ami" "latest" {
  most_recent = true
  owners      = local.os_filters[var.os_type].owners

  filter {
    name   = "name"
    values = [local.os_filters[var.os_type].name]
  }

  filter {
    name   = "architecture"
    values = [var.architecture]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
