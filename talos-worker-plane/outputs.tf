output "vm_ips" {
  description = "IP addresses of the created VMs"
  value = {
    for idx, vm in proxmox_vm_qemu.kube_nodes : idx => vm.default_ipv4_address
  }
}

output "vm_names" {
  description = "Names of the created VMs"
  value = {
    for idx, vm in proxmox_vm_qemu.kube_nodes : idx => vm.name
  }
}

output "vm_ids" {
  description = "VM IDs of the created VMs"
  value = {
    for idx, vm in proxmox_vm_qemu.kube_nodes : idx => vm.vmid
  }
}
