remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket         = "alfiia-terraform-state-bucket"
    key            = "${path_relative_to_include()}/terraform.tfstate" // TO DO: check if possible expose ws var here
    region         = "us-west-2"
    encrypt        = true
  }
}
