provider "aws" {
  region = var.region
}

provider "vault" {
  address   = var.vault_address
  token     = var.vault_token
  namespace = var.vault_namespace
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
