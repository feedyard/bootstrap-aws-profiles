# bootstrap-aws-profiles
Basic usage of assume role capability with multi-account architecture.

## Assumptions and Requirements

A single AWS account is used to create Groups with permissions to assume roles in other aws accounts. This 'profiles'
account will not contain any traditional infrastructure.  

have included a kms key for use with parameter store in the profile env to use 'chamber' secrets mgmt

## Dependencies

terraform
python3
invoke
ruby
awspec

## circleci implementation

The circleci workflow assumes the expected aws access information is provided via an encrypted file used to define
env variables.

```
profile_account_id=
profile_access_key=
profile_secret_key=
profile_region=us-east-1
```

