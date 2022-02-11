remote_state {
  backend = "s3"
  config = {
    bucket         = "pepe-arg-security-prod-tfstate"
    key            = "terraform/${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "pepe-arg-security-prod-tfstate-lock"
  }
}


locals {
  common_vars = yamldecode(file("common_vars.yaml"))
}

inputs = {
  environment = local.common_vars.environment
  owner       = local.common_vars.owner
  region      = local.common_vars.region
  assume_role = local.common_vars.assume_role
  github_repo = local.common_vars.github_repo
}
