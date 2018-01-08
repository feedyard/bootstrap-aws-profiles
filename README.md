# bootstrap-aws-profiles
Basic usage of assume role capability with multi-account architecture.

## Assumptions and Requirements

A single AWS account is used to create Groups with permissions to assume roles in other aws accounts.  
This 'profiles' account will not contain any infrastructure apart from roles/permission configuration.  


### terraform state





## Dependencies

terraform
python3
invoke
ruby
awspec

## circleci implementation

The circleci workflow assumes the expected aws access information is provided via an encrypted file used to define
env variables that include the aws account ids for each account that will have assume-role definition configured.

