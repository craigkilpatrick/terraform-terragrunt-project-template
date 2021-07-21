remote_state {
  backend = "s3"
  config = {
    bucket     = "us-east-1-{CHANGEME - ACCOUNTNUMBER}-terraform-savedstate"
    key        = "${path_relative_to_include()}/terraform.tfstate"
    region     = "us-east-1"
    encrypt    = true
    dynamodb_table = "terraform-lock-table"
  }
}

# include all values from the common.tfvars file
terraform {
  extra_arguments "common_vars" {
    commands = get_terraform_commands_that_need_vars()
    arguments = [
      "-var-file=${get_terragrunt_dir()}/${path_relative_from_include()}/common.tfvars"
    ]
  }
}
