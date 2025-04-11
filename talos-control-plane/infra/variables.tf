variable "proxmox_api_url" {
  description = "Proxmox API URL"
  type        = string
}

variable "proxmox_api_token_id" {
  description = "Proxmox API token ID"
  type        = string
}

variable "proxmox_api_token_secret" {
  description = "Proxmox API token secret"
  type        = string
}

variable "proxmox_nodes" {
  description = "Proxmox node name where VMs will be created"
  type        = list(string)
}

variable "vm_template_name" {
  description = "Name of the VM template to clone from"
  type        = string
}

variable "vm_count" {
  description = "Number of VMs to create"
  type        = number
  default     = 1
}

variable "vm_name_prefix" {
  description = "Prefix for VM names"
  type        = string
}

variable "vm_memory" {
  description = "Memory size in MB"
  type        = number
  default     = 8048
}

variable "vm_cores" {
  description = "Number of CPU cores"
  type        = number
  default     = 8
}

variable "vm_storage" {
  description = "Storage pool name"
  type        = string
  default     = ""
}

variable "vm_disk_size" {
  description = "Disk size in GB"
  type        = string
  default     = "20G"
}

variable "vm_start_id" {
  description = "Starting VM ID"
  type        = number
  default     = 100
}

variable "post_provisioning_script" {
  description = "Path to post-provisioning script to execute on VMs"
  type        = string
  default     = ""
}
