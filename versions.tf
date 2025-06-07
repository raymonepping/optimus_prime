terraform {
  required_version = ">= 1.3.0" # Or the minimum you want, ideally >= 1.3 or 1.5

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
