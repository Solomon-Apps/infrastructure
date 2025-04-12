include "root" {
  path = find_in_parent_folders()
}

include "module" {
  path = "./module.hcl"
}

generate "tfvars" {
  path              = "../control-plane.auto.tfvars"
  if_exists         = "overwrite"
  disable_signature = true
  contents          = <<-EOF
  vm_name_prefix = "talos-control-plane"
  vm_memory      = 8096   # 4GB RAM for control plane
  vm_cores       = 8      # CPU cores for control plane
  vm_disk_size   = "100G" # Larger disk for control plane


  # VM configuration
  vm_template_name = "talos-template"
  proxmox_nodes    = ["pve", "pvemiddle", "pvetop"]
EOF
}