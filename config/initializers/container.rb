# frozen_string_literal: true

require 'dry/container'

class Container
  extend Dry::Container::Mixin
end

# Register the Octokit module based on the environment
if Rails.env.test?
  require Rails.root.join('lib/stubs/octokit_stub')
  Container.register(:octokit_module, Stubs::OctokitStub)
else
  Container.register(:octokit_module, Octokit)
end
