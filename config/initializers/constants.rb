# frozen_string_literal: true

# frozen_string_interval: true

require 'octokit'
require Rails.root.join('lib/stubs/octokit_stub')

OCTOKIT_MODULE = Rails.env.test? ? OctokitStub : Octokit
