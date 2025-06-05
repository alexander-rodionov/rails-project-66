# frozen_string_literal: true

require_relative '../../lib/utils/bash_operations'
require_relative '../../lib/utils/mocks/bash_operations'
require_relative '../../lib/utils/github_operations'
require_relative '../../lib/utils/mocks/github_operations'

Container = Dry::Container.new

if Rails.env.test?
  Container.register(:bash_operations, Utils::Mocks::BashOperations)
  Container.register(:github_operations, Utils::Mocks::GithubOperations)
else
  Container.register(:bash_operations, Utils::BashOperations)
  Container.register(:github_operations, Utils::GithubOperations)
end
