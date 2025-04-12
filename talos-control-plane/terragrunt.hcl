include "root" {
  path = find_in_parent_folders()
}

include "module" {
  path = "./module.hcl"
}

generate "tfvars" {
  path              = "control-plane.auto.tfvars"
  if_exists         = "overwrite"
  disable_signature = true
  contents          = <<-EOF
  vm_name_prefix = "talos-control-plane"
  vm_memory      = 8096
  vm_cores       = 8 
  vm_disk_size   = "100G"
  vm_template_name = "talos-template"
  vm_iso = "talos-metal.iso"
  proxmox_nodes    = ["pve", "pvemiddle", "pvetop"]
EOF
}