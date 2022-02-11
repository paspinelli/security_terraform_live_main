terraform {
  source = "../../../resources/iac-alerts"
}

locals {
  custom_vars = yamldecode(file("${"custom_vars.yaml"}"))
}

include {
  path = find_in_parent_folders()
}

inputs = {
  bucket_name               = local.custom_vars.bucket_name
  bucket_acl                = local.custom_vars.bucket_acl
  versioning_enable         = local.custom_vars.versioning_enable
  lambda_name               = local.custom_vars.lambda_name
  lambda_description        = local.custom_vars.lambda_description
  lambda_handler            = local.custom_vars.lambda_handler
  source_path               = local.custom_vars.source_path
  lambda_policies           = local.custom_vars.lambda_policies
  lambda_number_of_policies = local.custom_vars.lambda_number_of_policies
}
