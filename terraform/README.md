# Getting it working

## Installing Terraform
It is recommended to use `tfenv` to manage your Terraform CLI versions:
```shell
$ brew install tfenv
$ tfenv install 1.4.2
$ tfenv use 1.4.2
```
Verify Terraform is installed by running:
```
$ terraform -help
Usage: terraform [-version] [-help] <command> [args]

The available commands for execution are listed below.
The most common, useful commands are shown first, followed by
less common or more advanced commands. If you're just getting
started with Terraform, stick with the common commands. For the
other commands, please read the help and docs before usage.
#...
```

## Running
In the root folder `./terraform`, run:

### Initialise
```
$ terraform init
Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

### Plan
```
$ terraform plan -out aws-changes
#...

Plan: 2 to add, 0 to change, 0 to destroy.

──────────────────────────────────────────────────────────────────────────

Saved the plan to: aws-changes

To perform exactly these actions, run the following command to apply:
    terraform apply "aws-changes"
```
- **Note 1:** You can call the file (`-out` arg) whatever you like.
- **Note 2:** You can run `terraform plan` however, you'll get the following warning:
```
Note: You didn't use the -out option to save this plan, so
Terraform can't guarantee to take exactly these actions if you run
"terraformapply" now.
```

### Apply
```
terraform apply aws-changes
```

# Learning

## `./main.tf`
### Provider
Before starting, we need to setup the AWS provider. According to the [Terraform Registry](https://registry.terraform.io/providers/hashicorp/aws/latest/docs), for Terraform 0.13 and later:
```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-2"
}
```
Credentials can be provided by using the `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, and optionally `AWS_SESSION_TOKEN` (for assumed roles) environment variables.
### Modules
These modules are what we create in the sub-folders. From here, we can pass in variables.

## `./create-s3-bucket/main.tf`
- Here, we define an [aws_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) resource block.
- Using a [for_each](https://developer.hashicorp.com/terraform/language/meta-arguments/for_each), it cycles through each region in the regions variable to create multiple new buckets.

**Note:** The regions variable is defined in from the `variables.tf` file in the root folder.

## `./create-s3-buckets/variables.tf`
Despite passing in the variable from the root `variables.tf` file, we still need to define it in the local file for it to be accessible!

## `./update-s3-buckets/main.tf`
The main difference between creating and updating S3 buckets, is that we no longer want to “create” the buckets. Trying to create the buckets will result in the following error:
```
Error: creating Amazon S3 (Simple Storage) Bucket (eu-central-1.lance.chum.bucket): BucketAlreadyOwnedByYou: Your previous request to create the named bucket succeeded and you already own it.
```
Instead, we use the [data resource](https://developer.hashicorp.com/terraform/language/data-sources) which “allows Terraform to use information defined outside of Terraform, defined by another separate Terraform configuration, or modified by functions.”

## `./update-s3-buckets/variables.tf`
Despite passing in the variable from the root `variables.tf` file, we still need to define it in the local file for it to be accessible!