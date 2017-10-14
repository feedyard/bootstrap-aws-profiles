# bootstrap-aws-profiles
Basic usage of assume role capability with multi-account architecture.

## Assumptions and Requirements

A single AWS account is used to create Groups with permissions to assume roles in other aws accounts.  
This 'profiles' account will not contain any infrastructure apart from roles/permission configuration.  


### terraform state



## Profile Account

Keys are assumed to be available as terraform env vars.  
THe profile account depends on:  
TF_VAR_profile_account_id
TF_VAR_profile_access_ley
TF_VAR_profile_secret_key

## Infrastructure Accounts

For each additional account where users are granted assume rights:
TF_VAR_account_access_key
TF_VAR_account_secret_key


## Dependencies

terraform
python3
invoke
ruby
awspec
