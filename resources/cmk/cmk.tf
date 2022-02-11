resource "aws_kms_external_key" "main" {
  description = var.description
  bypass_policy_lockout_safety_check = true
  valid_to = timeadd(timestamp(),"8700h")
  policy = templatefile("shared-account-policy.tpl", {
    destination_account  = var.destination_account
    security_account     = data.aws_caller_identity.current.account_id
    })
  lifecycle {
    ignore_changes = [
      valid_to
    ]
  }
  tags = var.tags
}

resource "aws_kms_alias" "main" {
  name          = "alias/CB_${var.country}_${var.destination_account}"
  target_key_id = aws_kms_external_key.main.id
}

output "aws_kms_external_key_id" {
  description = "The unique identifier for the key."
  value       = aws_kms_external_key.main.id
}

output "aws_kms_external_key_alias" {
  description = "The Amazon Resource Name (ARN) of the key alias."
  value       = aws_kms_alias.main.arn
}

