terraform {
  source = "../../../resources/cmk"
}

locals {
  custom_vars = yamldecode(file("${"custom_vars.yaml"}"))
  common_vars = yamldecode(file("${find_in_parent_folders("common_vars.yaml")}"))
}

include {
  path = find_in_parent_folders()
}

inputs = merge(
  local.custom_vars,
  local.common_vars
)
