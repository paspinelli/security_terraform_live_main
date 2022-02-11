variable "ip_set_name" {
  type = string
}

variable "ip_set_description" {
  type = string
}

variable "ip_set_adress_version" {
  type = string
}

variable "ip_set_scope" {
  type = string
}

variable "ip_set_adresses" {
  type = list(string)
}

variable "rulegroup_name" {
  type = string
}

variable "rulegroup_scope" {
  type = string
}

variable "rulegroup_capacity" {
  type = number
}

variable "rulegroup_cloudwatch_metrics_enabled" {
  type = bool
}

variable "rulegroup_metric_name" {
  type = string
}

variable "rulegroup_sampled_requests_enabled" {
  type = bool
}

variable "geo_rule_name" {
  type = string
}

variable "geo_rule_priority" {
  type = number
}

variable "geo_rule_country_codes" {
  type = list(string)
}

variable "geo_rule_cloudwatch_metrics_enabled" {
  type = bool
}

variable "geo_rule_metric_name" {
  type = string
}

variable "geo_rule_sampled_requests_enabled" {
  type = string
}

variable "ip_rule_name" {
  type = string
}

variable "ip_rule_priority" {
  type = number
}

variable "ip_rule_cloudwatch_metrics_enabled" {
  type = bool
}

variable "ip_rule_metric_name" {
  type = string
}

variable "ip_rule_sampled_requests_enabled" {
  type = string
}

variable "fms_policy_name" {
  type = string
}

variable "fms_policy_exclude_resource_tags" {
  type = bool
}

variable "fms_policy_remediation_enabled" {
  type = bool
}

variable "fms_policy_resource_type_list" {
  type = list(string)
}

variable "fms_policy_include_accounts" {
  type = list(string)
}

variable "fms_policy_tag_value" {
  type = string
}
