terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {}
}

provider "aws" {
  default_tags {
    tags = {
      Environment = var.environment
      Owner       = var.owner
      Repo        = var.github_repo
    }
  }
  region = var.region
  assume_role {
    role_arn = var.assume_role
  }
}

data "aws_caller_identity" "current" {}
