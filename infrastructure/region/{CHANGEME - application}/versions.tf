terraform {
  # The configuration 'backend' will be filled in by Terragrunt
  backend "s3" {}
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  required_version = ">= 0.15.4, < 1.0.0"
}
