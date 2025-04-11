locals {
    proxmox_api_url          = get_env("PROXMOX_API_URL", "")
    proxmox_api_token_id     = get_env("PROXMOX_API_TOKEN_ID", "")
    proxmox_api_token_secret = get_env("PROXMOX_API_TOKEN_SECRET", "")
    proxmox_nodes            = ["pve", "pvemiddle", "pvetop"]
}