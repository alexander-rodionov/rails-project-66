# frozen_string_literal: true

require_relative '../../lib/omniauth/strategies/mock_auth_strategy'

OmniAuth.config.allowed_request_methods = [:post]
OmniAuth.config.silence_get_warning = true

if Rails.env.development?
  OmniAuth.config.full_host = ENV.fetch('TEST_BASE_URL', 'http://localhost:3000')
else
  OmniAuth.config.full_host = ENV.fetch('BASE_URL', nil) if ENV.fetch('BASE_URL', nil).present?
end

Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.development?
    provider :mock_auth_strategy, name: 'github', callback_path: '/auth/github/callback'
  else
    provider :github,
             ENV.fetch('GITHUB_CLIENT_ID', nil),
             ENV.fetch('GITHUB_CLIENT_SECRET', nil),
             scope: 'user,public_repo,admin:repo_hook',
             callback_path: '/auth/github/callback'
  end
end
