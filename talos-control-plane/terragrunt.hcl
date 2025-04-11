terraform {
  source = "./infra"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  # VM configuration specific to k3s control plane
  vm_name_prefix = "talos-control-plane"
  vm_memory      = 8096  # 4GB RAM for control plane
  vm_cores       = 8     # CPU cores for control plane
  vm_disk_size   = "100G" # Larger disk for control plane


  # VM configuration
  vm_template_name = "talos-template"

  # Post-provisioning configuration
  post_provisioning_script = "${get_path_from_repo_root()}/scripts/install-server-server.sh"
}
