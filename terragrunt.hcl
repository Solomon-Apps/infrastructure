terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.0"
    }
  }
}


remote_state {
  backend = "remote"
  hostname = "app.terraform.io"
  config {
    organization = "solomon-apps"
    workspaces {
      name = "${path_relative_to_include()}"
    }
  }
}

inputs = {
  # proxmox_api_url          = var.proxmox_api_url
  # proxmox_api_token_id     = var.proxmox_api_token_id
  # proxmox_api_token_secret = var.proxmox_api_token_secret
  proxmox_nodes    = ["pve", "pvemiddle", "pvetop"]
}