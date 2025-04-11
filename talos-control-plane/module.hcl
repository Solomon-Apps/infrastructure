
terraform {
  source = "."

  required_var_files = [
    "${get_parent_terragrunt_dir()}/terraform.auto.tfvars"
  ]
}

