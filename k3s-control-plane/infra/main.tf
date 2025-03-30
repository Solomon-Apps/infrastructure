terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "2.9.0"
    }
  }
}

# Create VMs from template
resource "proxmox_vm_qemu" "kube_nodes" {
  count       = var.vm_count
  name        = "${var.vm_name_prefix}-${count.index + 1}"
  target_node = var.proxmox_node
  clone       = var.vm_template_name
  full_clone  = true
  memory      = var.vm_memory
  cores       = var.vm_cores
  sockets     = 1
  storage     = var.vm_storage
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

# Wait for VMs to be ready
resource "null_resource" "wait_for_vm" {
  count = var.vm_count
  depends_on = [proxmox_vm_qemu.kube_nodes]

  connection {
    type        = "ssh"
    user        = var.ssh_user
    password    = var.ssh_password
    host        = proxmox_vm_qemu.kube_nodes[count.index].default_ipv4_address
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Waiting for cloud-init to complete...'",
      "cloud-init status --wait"
    ]
  }
}

# Execute post-provisioning script if provided
resource "null_resource" "post_provisioning" {
  count = var.vm_count
  depends_on = [null_resource.wait_for_vm]

  connection {
    type        = "ssh"
    user        = var.ssh_user
    password    = var.ssh_password
    host        = proxmox_vm_qemu.kube_nodes[count.index].default_ipv4_address
  }

  provisioner "file" {
    source      = var.post_provisioning_script
    destination = "/tmp/post_provisioning.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/post_provisioning.sh",
      "/tmp/post_provisioning.sh"
    ]
  }
} 