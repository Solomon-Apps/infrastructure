remote_state {
  backend = "remote"
  hostname = "app.terraform.io"
  config {
    organization = "solomon-apps"
    workspaces {
      name = "${path_relative_to_include()}"
    }
  }
}

inputs = {
  proxmox_nodes = ["pve", "pvemiddle", "pvetop"]
}