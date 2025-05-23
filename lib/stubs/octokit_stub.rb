# frozen_string_literal: true

require_relative('octokit_stub_generators_1')
require_relative('octokit_stub_generators_2')

module Stubs
  module OctokitStub
    class Client
      include OctokitStubGenerators1
      include OctokitStubGenerators2
      def initialize(token)
        Rails.logger.debug token
      end

      def repos(_, _)
        generate_fake_github_repo
      end

      def user
        generate_fake_github_user
      end

      def languages(_)
        generate_fake_languages
      end

      def hooks(_)
        generate_fake_github_hooks_response
      end
    end
  end
end
