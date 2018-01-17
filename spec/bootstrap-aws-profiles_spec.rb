# frozen_string_literal: true

require 'spec_helper'

describe iam_group('AssumeNonprodRoleGroup') do
  it { should exist }
end

describe iam_group('AssumeProdRoleGroup') do
  it { should exist }
end

describe iam_group('UseParameterStoreGroup') do
  it { should exist }
  it { should have_iam_policy('UseParameterStorePolicy') }
  it { should be_allowed_action('ssm:DescribeParameters').resource_arn('arn:aws:ssm:us-east-1:667882779648:*') }
end