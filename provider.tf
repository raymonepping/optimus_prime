provider "aws" {
  region     = var.region
  access_key = data.vault_kv_secret_v2.aws_creds.data["AWS_ACCESS_KEY_ID"]
  secret_key = data.vault_kv_secret_v2.aws_creds.data["AWS_SECRET_ACCESS_KEY"]
  token      = lookup(data.vault_kv_secret_v2.aws_creds.data, "AWS_SESSION_TOKEN", null)
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
