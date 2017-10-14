# state files for x-account assume role configuration maintained in profile account
# the ~/.aws/credentials file is populated at deployment runtime with the profile information
terraform {
  required_version = ">= 0.10.6"

  backend "s3" {
    bucket  = "feedyard-profile-local"
    key     = "boostrap-profile-groups/auth.tfstate"
    region  = "us-east-1"
    profile = "bootstrap-profile"
  }
}

# env passed via encrypted file
variable "profile_account_id" {}
variable "profile_access_key" {}
variable "profile_secret_key" {}
variable "profile_region" {}
