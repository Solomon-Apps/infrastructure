locals {
  proxmox_api_url          = get_env("PROXMOX_API_URL", "")
  proxmox_api_token_id     = get_env("PROXMOX_API_TOKEN_ID", "")
  proxmox_api_token_secret = get_env("PROXMOX_API_TOKEN_SECRET", "")
}

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
  pm_api_url          = "${local.proxmox_api_url}"
  pm_api_token_id     = "${local.proxmox_api_token_id}"
  pm_api_token_secret = "${local.proxmox_api_token_secret}"
  pm_tls_insecure     = true
}
EOF
}

prevent_destroy = true  # Stops it from being treated like a real module
inputs = {}

terraform {
  extra_arguments "tfvars" {
    commands = get_terraform_commands_that_need_vars()
    arguments = [
      "-var-file=${path_relative_from_include()}/terraform.auto.tfvars"
    ]
  }
}