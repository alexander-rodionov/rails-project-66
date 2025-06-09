# frozen_string_literal: true

require_relative 'utils/bash_operations'
require_relative 'utils/mocks/bash_operations'
require_relative 'utils/github_operations'
require_relative 'utils/mocks/github_operations'


class ApplicationContainer
  extend Dry::Container::Mixin

  if Rails.env.test?
    register(:bash_operations, Utils::Mocks::BashOperations)
    register(:github_operations, Utils::Mocks::GithubOperations)
  else
    register(:bash_operations, Utils::BashOperations)
    register(:github_operations, Utils::GithubOperations)
  end
end



