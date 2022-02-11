resource "aws_wafv2_ip_set" "ip_set_blacklist" {
  name               = var.ip_set_name
  description        = var.ip_set_description
  ip_address_version = var.ip_set_adress_version
  scope              = var.ip_set_scope
  addresses          = var.ip_set_adresses
}

resource "aws_wafv2_rule_group" "basic_regional_rules" {
  name     = var.rulegroup_name
  scope    = var.rulegroup_scope
  capacity = var.rulegroup_capacity

  rule {
    name     = var.geo_rule_name
    priority = var.geo_rule_priority

    action {
      count {}
    }

    statement {
      not_statement {
        statement {
          geo_match_statement {
            country_codes = var.geo_rule_country_codes
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = var.geo_rule_cloudwatch_metrics_enabled
      metric_name                = var.geo_rule_metric_name
      sampled_requests_enabled   = var.geo_rule_sampled_requests_enabled
    }
  }

  rule {
    name     = var.ip_rule_name
    priority = var.ip_rule_priority

    action {
      block {}
    }

    statement {

      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.ip_set_blacklist.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = var.ip_rule_cloudwatch_metrics_enabled
      metric_name                = var.ip_rule_metric_name
      sampled_requests_enabled   = var.ip_rule_sampled_requests_enabled
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = var.rulegroup_cloudwatch_metrics_enabled
    metric_name                = var.rulegroup_metric_name
    sampled_requests_enabled   = var.rulegroup_sampled_requests_enabled
  }
}

resource "aws_fms_policy" "fms-basic-policy" {
  name                  = var.fms_policy_name
  exclude_resource_tags = var.fms_policy_exclude_resource_tags
  remediation_enabled   = var.fms_policy_remediation_enabled
  resource_type_list    = var.fms_policy_resource_type_list

  include_map {
    account = var.fms_policy_include_accounts
  }

  resource_tags = {
    fms = var.fms_policy_tag_value
  }

  security_service_policy_data {

    type = "WAFV2"
    managed_service_data = jsonencode(
      {
        "type" : "WAFV2",
        "preProcessRuleGroups" : [
          {
            "ruleGroupArn" : null,
            "overrideAction" : {
              "type" : "COUNT"
            },
            "managedRuleGroupIdentifier" : {
              "version" : null,
              "vendorName" : "AWS",
              "managedRuleGroupName" : "AWSManagedRulesCommonRuleSet"
            },
            "ruleGroupType" : "ManagedRuleGroup",
            "excludeRules" : []
          },
          {
            "ruleGroupArn" : null,
            "overrideAction" : {
              "type" : "COUNT"
            },
            "managedRuleGroupIdentifier" : {
              "version" : null,
              "vendorName" : "AWS",
              "managedRuleGroupName" : "AWSManagedRulesAmazonIpReputationList"
            },
            "ruleGroupType" : "ManagedRuleGroup",
            "excludeRules" : []
          },
          {
            "ruleGroupArn" : null,
            "overrideAction" : {
              "type" : "COUNT"
            },
            "managedRuleGroupIdentifier" : {
              "version" : null,
              "vendorName" : "AWS",
              "managedRuleGroupName" : "AWSManagedRulesAnonymousIpList"
            },
            "ruleGroupType" : "ManagedRuleGroup",
            "excludeRules" : []
          },
          {
            "ruleGroupArn" : aws_wafv2_rule_group.basic_regional_rules.arn,
            "overrideAction" : {
              "type" : "NONE"
            },
            "managedRuleGroupIdentifier" : null,
            "ruleGroupType" : "RuleGroup",
            "excludeRules" : []
          }
        ],
        "postProcessRuleGroups" : [],
        "defaultAction" : {
          "type" : "ALLOW"
        },
        "overrideCustomerWebACLAssociation" : true,
        "loggingConfiguration" : null
      }
    )
  }
}
