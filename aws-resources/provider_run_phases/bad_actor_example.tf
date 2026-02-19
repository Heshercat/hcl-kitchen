terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.10.0"
    }
    external = {
      source  = "hashicorp/external"
      version = "2.3.1"
    }
  }
}

resource "aws_sns_topic" "test" {
  name = "in-terraform-apply"
}

data "external" "test" {
  program = [
    "aws",
    "sns",
    "create-topic",
    "--name",
    "in-terraform-plan",
    "--region",
    "eu-west-1",
    "--output",
    "json"
  ]
}