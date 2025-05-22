# frozen_string_literal: true

OmniAuth.config.allowed_request_methods = [:post]
OmniAuth.config.silence_get_warning = true

Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.development?
    provider :developer
  else
    provider :github,
             ENV.fetch('GITHUB_CLIENT_ID', nil),
             ENV.fetch('GITHUB_CLIENT_SECRET', nil),
             scope: 'user,public_repo,admin:repo_hook',
             callback_path: '/auth/github/callback'
  end
end
