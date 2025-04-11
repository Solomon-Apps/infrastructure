terraform {
  source = "./infra"
}

include "root" {
  path = find_in_parent_folders()
}

locals {
  common = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}

inputs = {
  # VM configuration specific to k3s control plane
  vm_name_prefix = "talos-control-plane"
  vm_memory      = 8096  # 4GB RAM for control plane
  vm_cores       = 8     # CPU cores for control plane
  vm_disk_size   = "100G" # Larger disk for control plane


  # VM configuration
  vm_template_name = "talos-template"

  proxmox_api_url          = local.common.common_inputs.proxmox_api_url
  proxmox_api_token_id     = local.common.common_inputs.proxmox_api_token_id
  proxmox_api_token_secret = local.common.common_inputs.proxmox_api_token_secret
  proxmox_nodes            = local.common.common_inputs.proxmox_nodes
}
