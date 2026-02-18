locals {
  state_prefix = get_env("SCALR_WORKSPACE_ID")
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket         = "alfiia-terraform-state-bucket"
    key            = "${local.state_prefix}/${path_relative_to_include()}/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
  }
}
