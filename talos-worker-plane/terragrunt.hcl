include "root" {
  path = find_in_parent_folders()
}

include "module" {
  path = "./module.hcl"
}

generate "tfvars" {
  path              = "worker-plane.auto.tfvars"
  if_exists         = "overwrite"
  disable_signature = true
  contents          = <<-EOF
  vm_name_prefix = "talos-worker-plane"
  vm_memory      = 16096
  vm_cores       = 16
  vm_disk_size   = "500G"
  vm_template_name = "talos-template"
  vm_iso = "local:iso/talos-metal.iso"
  vm_count = 6
  proxmox_nodes    = ["pve", "pvemiddle", "pvetop"]
EOF
}