# Auto-generated provider configurations

provider "aws" {
  region = var.region
}

provider "vault" {
  region = var.region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.99.1"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 5.0.0"
    }
  }
}
