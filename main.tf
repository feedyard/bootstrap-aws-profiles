provider "aws" {
  alias = "profile"
  region = "us-east-1"
  access_key="${var.profile_access_key}"
  secret_key="${var.profile_secret_key}"
}

resource "aws_iam_group" "assume_nonprod_role_group" {
  provider = "aws.profile"
  name = "AssumeNonprodRoleGroup"
}

resource "aws_iam_group" "assume_prod_role_group" {
  provider = "aws.profile"
  name = "AssumeProdRoleGroup"
}