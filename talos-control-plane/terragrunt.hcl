include "root" {
  path = find_in_parent_folders()
}

include "module" {
  path = "./module.hcl"
}