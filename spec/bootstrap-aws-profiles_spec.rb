# frozen_string_literal: true

require 'spec_helper'

tfvars = JSON.parse(File.read('./variables.tfvars'))

describe iam_group('AssumeNonprodRoleGroup') do
  it { should exist }
  it { should have_inline_policy('AssumeNonprodRolePolicy') }
  it { should be_allowed_action('sts:AssumeRole').resource_arn('arn:aws:iam::' + tfvars['sandbox_account_id'] + ':role/TerraformRole') }
  it { should be_allowed_action('sts:AssumeRole').resource_arn('arn:aws:iam::' + tfvars['nonprod_account_id'] + ':role/TerraformRole') }
  it { should be_allowed_action('sts:AssumeRole').resource_arn('arn:aws:iam::' + tfvars['sandbox_account_id'] + ':role/KopsRole') }
  it { should be_allowed_action('sts:AssumeRole').resource_arn('arn:aws:iam::' + tfvars['nonprod_account_id'] + ':role/KopsRole') }
end

describe iam_group('AssumeProdRoleGroup') do
  it { should exist }
  it { should have_inline_policy('AssumeProdRolePolicy') }
  it { should be_allowed_action('sts:AssumeRole').resource_arn('arn:aws:iam::' + tfvars['prod_account_id'] + ':role/TerraformRole') }
  it { should be_allowed_action('sts:AssumeRole').resource_arn('arn:aws:iam::' + tfvars['prod_account_id'] + ':role/KopsRole') }
end

describe iam_group('AssumeProfileRoleGroup') do
  it { should exist }
  it { should have_inline_policy('AssumeProfileRolePolicy') }
  it { should be_allowed_action('sts:AssumeRole').resource_arn('arn:aws:iam::' + tfvars['profile_account_id'] + ':role/TerraformRole') }
end

describe iam_group('DefaultIAMUsersGroup') do
  it { should exist }
  it { should have_inline_policy('AssumeReadonlyRolePolicy') }
  it { should be_allowed_action('sts:AssumeRole').resource_arn('arn:aws:iam::' + tfvars['profile_account_id'] + ':role/ReadOnlyRole') }
  it { should be_allowed_action('sts:AssumeRole').resource_arn('arn:aws:iam::' + tfvars['sandbox_account_id'] + ':role/ReadOnlyRole') }
  it { should be_allowed_action('sts:AssumeRole').resource_arn('arn:aws:iam::' + tfvars['nonprod_account_id'] + ':role/ReadOnlyRole') }
  it { should be_allowed_action('sts:AssumeRole').resource_arn('arn:aws:iam::' + tfvars['prod_account_id'] + ':role/ReadOnlyRole') }
  it { should have_inline_policy('UseParameterStorePolicy') }
end

describe kms('parameter_store_key') do
  it { should exist }
  it { should be_enabled }
end