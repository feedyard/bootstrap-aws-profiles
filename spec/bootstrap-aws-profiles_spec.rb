# frozen_string_literal: true

require 'spec_helper'

describe iam_group('AssumeNonprodRoleGroup') do
  it { should exist }
end

describe iam_group('AssumeProdRoleGroup') do
  it { should exist }
end