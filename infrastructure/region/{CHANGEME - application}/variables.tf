# -------------------------------------------------------------------
# AWS Connectivity
# -------------------------------------------------------------------
variable "aws_region" {
  description = "The name of the AWS region to set up a network within"
}

provider "aws" {
  region = var.aws_region
}

variable "default_tags" {
  type    = map(string)
  default = {}
}

variable "{CHANGEME - application_name}_tags" {
  type    = map(string)
  default = {}
}
