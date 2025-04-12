# Create VMs from template
resource "proxmox_vm_qemu" "kube_nodes" {
  count       = length(var.proxmox_nodes) * var.vm_count
  name        = "${var.vm_name_prefix}-${var.proxmox_nodes[floor(count.index / var.vm_count)]}-${(count.index % var.vm_count) + 1}"
  target_node = var.proxmox_nodes[floor(count.index / var.vm_count)]
  clone       = var.vm_template_name
  full_clone  = true
  memory      = var.vm_memory
  cores       = var.vm_cores
  sockets     = 1
  vm_state    = "running"
  disk {
    type    = "scsi"
    storage = var.vm_storage
    size    = var.vm_disk_size
  }
  network {
    bridge = "vmbr0"
    model  = "virtio"
  }
  lifecycle {
    ignore_changes = [
      network,
      disk
    ]
  }
}


resource "null_resource" "wait_for_nodes" {
  provisioner "local-exec" {
    command = "echo Deployed Talos Control Plane"

  }
  depends_on = [
    proxmox_vm_qemu.kube_nodes
  ]
}
