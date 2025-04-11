# Indicate what region to deploy the resources into
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "solomon-apps"
    workspaces {
      name = "proxmox-infrastructure"
    }
  }

  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "2.9.0"
    }
  }
}

provider "proxmox" {
  pm_api_url          = var.proxmox_api_url
  pm_api_token_id     = var.proxmox_api_token_id
  pm_api_token_secret = var.proxmox_api_token_secret
  pm_tls_insecure     = true
}
EOF
}

# Indicate the input values to use for the variables of the module.
inputs = {
  infra = "${path_relative_to_include()}"

  # Proxmox connection details
  proxmox_api_url          = get_env("PROXMOX_API_URL", "")
  proxmox_api_token_id     = get_env("PROXMOX_API_TOKEN_ID", "")
  proxmox_api_token_secret = get_env("PROXMOX_API_TOKEN_SECRET", "")
  proxmox_nodes            = ["pve", "pvemiddle", "pvetop"]
}
