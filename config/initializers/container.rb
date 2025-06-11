# frozen_string_literal: true

require_relative '../../lib/utils/command_launcher'
require_relative '../../lib/utils/mocks/command_launcher'
require_relative '../../lib/utils/github_operations'
require_relative '../../lib/utils/mocks/github_operations'

class ApplicationContainer
  extend Dry::Container::Mixin

  if Rails.env.test?
    register(:command_launcher, Utils::Mocks::CommandLauncher)
    register(:github_operations, Utils::Mocks::GithubOperations)
  else
    register(:command_launcher, Utils::CommandLauncher)
    register(:github_operations, Utils::GithubOperations)
  end
end
