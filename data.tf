data "vault_kv_secret_v2" "example" {
  mount = "secret"
  name  = "AWS"
}
