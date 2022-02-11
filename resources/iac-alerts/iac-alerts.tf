resource "aws_s3_bucket" "iac_alerts_bucket" {
  bucket = var.bucket_name
  acl    = var.bucket_acl

  versioning {
    enabled = var.versioning_enable
  }

  server_side_encryption_configuration{
      rule {
          apply_server_side_encryption_by_default{
              sse_algorithm = var.sse_algorithm
          }
      }
  }
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.iac_alerts_bucket.id

  lambda_function {
    lambda_function_arn = module.lambda_send_result_to_slack.lambda_function_arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_permission.allow_bucket]
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_send_result_to_slack.lambda_function_arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.iac_alerts_bucket.arn
}

module "lambda_send_result_to_slack" {
  source = "terraform-aws-modules/lambda/aws"

  function_name      = var.lambda_name
  description        = var.lambda_description
  handler            = var.lambda_handler
  runtime            = var.lambda_runtime
  source_path        = var.source_path
  attach_policies    = true
  policies           = var.lambda_policies
  number_of_policies = var.lambda_number_of_policies
}