# -------------------------------------------------------------------
# Terraform
# -------------------------------------------------------------------
### These settings need to be in all the terragrunt.hcl files for the infrastructure you want to apply
### Terragrunt will pull the settings from the root terragrunt.hcl file in the region folder
### This will enable it know where to store the terraform state file (s3) and create the correct folder structure there for you
terraform {
  source = "../../../../../..//infrastructure/region/{CHANGEME - application folder you rename from the template}/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# -------------------------------------------------------------------
# Variables for modules
# -------------------------------------------------------------------
inputs = {
    {CHANGEME - application_name}_tags = {} # additional tags for all application folder specific resources, if needed.
}
