generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "proxmox" {
  pm_api_url          = "${get_env("PROXMOX_API_URL")}"
  pm_api_token_id     = "${get_env("PROXMOX_API_TOKEN_ID")}"
  pm_api_token_secret = "${get_env("PROXMOX_API_TOKEN_SECRET")}"
  pm_tls_insecure     = true
}
EOF
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  backend "remote" {
    organization = "solomon-apps"
    workspaces {
      name = "${path_relative_to_include()}"
    }
  }
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.0"
    }
  }
}
EOF
}

skip = true