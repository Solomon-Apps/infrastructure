terraform {
  source = "./infra"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  # VM configuration specific to k3s control plane
  vm_name_prefix = "k3s-control-plane"
  vm_count = 1
  vm_memory = 4096  # 4GB RAM for control plane
  vm_cores = 4      # 4 CPU cores for control plane
  vm_disk_size = "70G"  # Larger disk for control plane


  # VM configuration
  vm_template_name = "ubuntu-server-barebones"
  
  # SSH configuration for post-provisioning
  ssh_user = "ks3-control-plane"
  ssh_password = get_env("SSH_PASSWORD", "")  # Get SSH password from environment variable
  
  # Post-provisioning configuration
  post_provisioning_script = "${get_path_from_repo_root()}/scripts/install-k3s-server.sh"
}