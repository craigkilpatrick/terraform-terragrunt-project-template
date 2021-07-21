/*

Common Variables - Add variables here that will apply in ALL folders of
your Terraform code.

Beginning with Terraform 0.12+, folders that don't use all variables here
will display a deprecation warning. In future releases, errors will occur.

Keep variable values in just the folder where needed, or will need to be
needlessly declared in the folder where this value is not needed, to avoid
the warning/error.

*/
# -------------------------------------------------------------------
# General global account/project/region level values

aws_env_name        = "{CHANGEME - PRODUCTNAME}-{CHANGEME - ENVIRONMENT}" # all lowercase, ex. igo-sandbox, esb-qa, etc.
aws_region          = "us-east-1"
availability_zone_a = "us-east-1a"
availability_zone_b = "us-east-1b"
# any formatted var values can be used as-is for nice tagging, descriptions, etc., or all lower case if needed with lower(var.name), or if within a string, ${lower(var.name)}
project     = "{CHANGEME - PROJECT NAME}" # ESB, iGO, etc., formatted nicely with caps where appropriate
environment = "{CHANGEME - ENVIRONMENT}" # Sandbox, QA, etc, formatted nicely with caps where appropriate

default_tags = { # default set of tags to include for ALL resources, in addition to others added to individual resources
  # any of these can be referenced individually for use in naming resources, building additional tags, ex. $
  Automation  = "Terraform"
  Customer    = "{CHANGEME - CUSTOMER NAME}"
  Environment = "Sandbox" # Sandbox, QA, etc. Formatted nicely with caps where appropriate
  Product     = "{CHANGEME - PRODUCT NAME}" # ESB, iGO, etc., formatted nicely with caps where appropriate.
  Terraform   = "True"
}
creator_tags = { # core folder has a 'core_creator_tags' with a different creator. Merging this to default_tags will overwrite that.
  Creator = "{CHANGEME - PROJECT CODE WRITER}"
}
account_id = "{CHANGEME - ACCOUNT_ID}"
