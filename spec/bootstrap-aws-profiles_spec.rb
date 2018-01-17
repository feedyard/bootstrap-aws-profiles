# frozen_string_literal: true

require 'spec_helper'

describe iam_group('AssumeNonprodRoleGroup') do
  it { should exist }
  # it { should have_inline_policy('UseParameterStorePolicy') }
end

describe iam_group('AssumeProdRoleGroup') do
  it { should exist }
  # it { should have_inline_policy('UseParameterStorePolicy') }
end

describe iam_group('UseParameterStoreGroup') do
  it { should exist }
  it { should have_inline_policy('UseParameterStorePolicy') }
end