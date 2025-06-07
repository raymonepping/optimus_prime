data "vault_kkv2_secret" "aws_creds" {
  mount  = "secret"
  name   = "aws"
}
