# Terraform-Project-Template

When you are developing a new AWS project and using [Terraform](https://www.terraform.io/) with [Terragrunt](https://github.com/gruntwork-io/terragrunt) to write your infrastructure as code, you will need to setup a github project for the code repository.

The **"Terraform-Project-Template"** project provides you with a structure for this project with some of the required files and variables created (including some helpful settings in the *.gitignore* and *.gitsettings*).  There are also some example subfolders, which can be used to inform your thinking regarding the layout of your code and variables.

It is the intention of the team to automate the new account creation process to include the creation of the Terraform code project in GitHub, however in the meantime please refer to this document for guidance, and speak to other team members for further assistance.

<!-- TOC -->

- [Terraform-Project-Template](#terraform-project-template)
	- [Guidance](#guidance)
		- [Terraform Version](#terraform-version)
	- [Quick Start](#quick-start)
- [Details](#details)
	- [Folder Structure](#folder-structure)
		- [The "applied" folder](#the-applied-folder)
		- [The "infrastructure" folder](#the-infrastructure-folder)
		- [Example Folder Layout](#example-folder-layout)

<!-- /TOC -->

## Guidance

### Versioning
Reference the repo release version rather than branch name.

|Release|Terraform|Terragrunt|Notes|
|:---:|:---:|:---:|:---|
|`v5.0.0`|`0.15.4`|`0.29.5`|Terraform 0.15 support, starting with 0.15.4+. Update providers in lock.hcl files. Point to TF 0.15.4 version of modules used.|
|`v4.0.0`|`0.14.11`|`0.28.24`|Terraform 0.14 support, starting with 0.14.11+. Introduces .terraform.lock.hcl files. Point to TF 0.14.11 version of modules used.|
|`v3.0.0`|`0.13.7`|`0.26.7`|Terraform 0.13 support, starting with 0.13.7+. 'versions.tf' files now used to config Terraform, as they are created in the upgrade process, and the amount of config required within the block is expanding.|
|`v2.2.0`|`0.12.31`|`0.24.4`|Update to latest version of TF 0.12 due to their keys being rotated, newest version of Terragrunt before they moved on to 0.13 support. Point to TF 0.12.31 version of modules used.|
|`v2.1.4`|`0.12.29`|`0.23.27`|add a missing CHANGEME to template|
|`v2.1.3`|`0.12.29`|`0.23.27`|subnet tag fix|
|`v2.1.2`|`0.12.29`|`0.23.27`|bug fixes, tag adjusts and add missing var from v2.1.1|
|`v2.1.1`|`0.12.29`|`0.23.27`|missing creator tags add, codepipeline var name adjust|
|`v2.1.0`|`0.12.29`|`0.23.27`|revisions, update to 0.12.29, add codepipeline and systems manager setups|
|`v2.0.0`|`0.12.20`|`0.21.11`|upgraded to Terraform 0.12|
|`v1.0.0`|`0.11.11`|`<0.19`|legacy template on Terraform 0.11.11|

### Terraform Version
The current guidance for Terraform is version: **0.14.11** <br>

To apply guidance:
- In variables.tf
```
terraform {
  backend "s3" {}
}
```
- In variables.tf
```
terraform {
  required_version = "0.14.11"
}
```

## Quick Start

1. Create a github repo for your project e.g "ACME-terraform"
2. Clone the new "ACME-terraform" repo to a folder on your HDD
3. Clone this template project
4. Copy the "applied" and "infrastructure folders to your new GitHub project
5. Copy the .gitignore and .gitsettings file to your project folder
6. Browse to the "applied/accounts/sandbox/us-east-1/" folder and edit the **terragrunt.hcl**
	* Edit the bucket name -- Replacing "**{CHANGEME - ACCOUNTNUMBER}**" with then account number of the AWS account
	* Edit (if required) the region reference
```
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
```
5. Edit the **common.tfvars** in the same folder replacing any values with those suitable for your project.
6. Search all files for ```{CHANGEME```. All places where this exist are where to supply your values. Remove the brackets around it too. Leave the quotes if present, and if no quotes, they are not required in that location.
7. Commit and push changes back to your new project GitHub project.
```
git remote add origin git@github.com:{GIT ORG NAME HERE}/{GIT REPO NAME HERE}.git
git push -u origin master
```

# Details

The goal of the project layout is to help separate your code (the definitions of the infrastructure you want to apply), from the variables.

It is these **variables** that we use to  differentiate the deployments between accounts (e.g. Sandbox and UAT), or Regions (e.g. us-east-1 and us-west-2)

The goal is to try and keep the Terraform code *dry*; only needing (where possible) to define the code once, but applying it to all our different AWS accounts, with just the variables that change.

## Folder Structure

You will notice that there are two top level folders

* [applied](#the-applied-folder)
* [infrastructure](#the-infrastructure-folder)

### The "applied" folder

This folder contains the variables that are ***applied*** to your code when it runs. The variables are used separate out deployments between environments.

The folder is sub-divided into:
- **“accounts”** - with a folder for each of the different accounts you are working in e.g. Sandbox, UAT, PROD
- Then the **“region”** e.g. us-east-1
- Finally into folders that contain the variables file for the code you are deploying, e.g. **“app-tier"**

These final folders can be sub-divided further depending on the requirements of your project.

> NOTE:  It is from these folders (containing the terragrunt.hcl files) that you run your "terragrunt" commands.
>
> When Terragrunt executes it looks at the folder structure and automatically creates the folders in our s3 bucket, and stores the **"STATE"** file for the code in the s3 folder.

### The "infrastructure" folder

This contains the actual Terraform code that you are deploying to and account and to a region.

The folder is sub-divided into:

- **"modules"** - this can be used to store re-usable Terraform modules that be used can deploy more complex combinations of infrastructure.  
- **"region"** - this contains the actual code you are deploying into the account / region. It can be further sub-divided into more logic units of code, depending on your requirements

### Example Folder Layout

> NOTE: Notice how the structure of the two folders -- from the "region" down, mirror each other.

```
── applied
│   └── accounts
│       └── sandbox
│           └── us-east-1
│               ├── saas-product
│               │   ├── app-tier
│               │   │   └── terragrunt.hcl
│               │   └── database
│               │       └── terragrunt.hcl
│               ├── single-tenant-product
│               │   └── customerA
│               │       ├── app-tier
│               │       │   └── terragrunt.hcl
│               │       └── database
│               │           └── terragrunt.hcl
│               ├── core
│               │   └── terragrunt.hcl
│               ├── common.tfvars
│               └── terragrunt.hcl
├── infrastructure
│   ├── modules
│   └── region
│       ├── saas-product
│       │   ├── app-tier
│       │   │   ├── main.tf
│       │   │   ├── outputs.tf
│       │   │   └── variables.tf
│       │   └── database
│       │       ├── main.tf
│       │       ├── outputs.tf
│       │       └── variables.tf
│       ├── single-tenant-product
│       │   └── customerA
│       │       ├── app-tier
│       │       │   ├── main.tf
│       │       │   ├── outputs.tf
│       │       │   └── variables.tf
│       │       └── database
│       │           ├── main.tf
│       │           ├── outputs.tf
│       │           └── variables.tf
│       └── core
│           ├── main.tf
│           ├── outputs.tf
│           └── variables.tf
└── README.md
```
