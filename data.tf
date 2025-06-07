data "vault_kv_secret_v2" "aws_creds" {
  mount = "secret"
  name  = "aws"
}
