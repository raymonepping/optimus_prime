# optimus_prime

Terraform project to provision AWS,VAULT infrastructure.

## Requirements

- Terraform >= 1.3
- GitHub CLI (gh)
- terraform-docs (optional)

## Usage

```bash
terraform init
terraform plan
terraform apply
```

## Structure

```
.
├── main.tf
├── provider.tf
├── variables.tf
├── outputs.tf
├── backend.tf
├── versions.tf
├── data.tf
├── locals.tf
└── modules/
    ├── compute/
    └── network/
```
