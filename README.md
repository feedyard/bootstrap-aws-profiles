# bootstrap-aws-profiles
Basic demo of assume role capability with multi-account architecture.

## Assumptions and Requirements

A single AWS account is used to create Groups with permissions to assume roles in other aws accounts. This 'profiles'
account will not contain any traditional infrastructure. 

In the simple example, a user in the AssumeNonprodRoleGroup is able to assume all defined roles in the nonproduction
accounts. Likewise for the AssumeProdRoleGroup.

Also creates a default iam user groups that infra devs are added to that enables ReadOnly across accounts and includes
the mecessary permissions and a kms key for use with parameter store in the profile env to use 'chamber' secrets mgmt

## Dependencies

See Dockerfile in [circleci-infra-agent](https://github.com/feedyard/circleci-infra-agent) for dependencies  

## circleci implementation

The circleci workflow assumes the expected aws access information is provided via an encrypted file used to define
env variables.

```
PROFILE_ACCESS_KEY_ID=
PROFILE_SECRET_ACCESS_KEY=
```
