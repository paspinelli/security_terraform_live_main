terraform {
  source = "../../../resources/fms"
}

locals {
  custom_vars = yamldecode(file("${"custom_vars.yaml"}"))
}

include {
  path = find_in_parent_folders()
}

inputs = {
  ip_set_name                          = local.custom_vars.ip_set_name
  ip_set_description                   = local.custom_vars.ip_set_description
  ip_set_adress_version                = local.custom_vars.ip_set_adress_version
  ip_set_scope                         = local.custom_vars.ip_set_scope
  ip_set_adresses                      = local.custom_vars.ip_set_adresses
  rulegroup_name                       = local.custom_vars.rulegroup_name
  rulegroup_scope                      = local.custom_vars.rulegroup_scope
  rulegroup_capacity                   = local.custom_vars.rulegroup_capacity
  rulegroup_cloudwatch_metrics_enabled = local.custom_vars.rulegroup_cloudwatch_metrics_enabled
  rulegroup_metric_name                = local.custom_vars.rulegroup_metric_name
  rulegroup_sampled_requests_enabled   = local.custom_vars.rulegroup_sampled_requests_enabled
  ip_rule_name                         = local.custom_vars.ip_rule_name
  ip_rule_priority                     = local.custom_vars.ip_rule_priority
  ip_rule_cloudwatch_metrics_enabled   = local.custom_vars.ip_rule_cloudwatch_metrics_enabled
  ip_rule_metric_name                  = local.custom_vars.ip_rule_metric_name
  ip_rule_sampled_requests_enabled     = local.custom_vars.ip_rule_sampled_requests_enabled
  geo_rule_name                        = local.custom_vars.geo_rule_name
  geo_rule_priority                    = local.custom_vars.geo_rule_priority
  geo_rule_country_codes               = local.custom_vars.geo_rule_country_codes
  geo_rule_cloudwatch_metrics_enabled  = local.custom_vars.geo_rule_cloudwatch_metrics_enabled
  geo_rule_metric_name                 = local.custom_vars.geo_rule_metric_name
  geo_rule_sampled_requests_enabled    = local.custom_vars.geo_rule_sampled_requests_enabled
  fms_policy_name                      = local.custom_vars.fms_policy_name
  fms_policy_exclude_resource_tags     = local.custom_vars.fms_policy_exclude_resource_tags
  fms_policy_remediation_enabled       = local.custom_vars.fms_policy_remediation_enabled
  fms_policy_resource_type_list        = local.custom_vars.fms_policy_resource_type_list
  fms_policy_include_accounts          = local.custom_vars.fms_policy_include_accounts
  fms_policy_tag_value                 = local.custom_vars.fms_policy_tag_value
}
