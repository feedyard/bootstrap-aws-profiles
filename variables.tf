# state files for x-account assume role configuration maintained in profile account
# the ~/.aws/credentials file is populated at deployment runtime with the profile information
terraform {
  required_version = ">= 0.11"

  backend "s3" {
  }
}

provider "aws" {
  version = "~> 1.51"
  region = "${var.profile_region}"
}

variable "profile_account_id" {}
variable "profile_region" { default = "us-east-1"}

# for each account added to the groups with assume rights
variable "sandbox_account_id" {}
variable "nonprod_account_id" {}
variable "prod_account_id" {}
