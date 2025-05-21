if Rails.env.development?
  dotenv_required = %w[GITHUB_CLIENT_ID GITHUB_CLIENT_ID]
  dotenv_required << %w[PG_HOST PG_PORT PG_NAME PG_USER PG_PASSWORD]
  dotenv_required << %w[RAILS_MAX_THREADS]
  Dotenv.require_keys(dotenv_required)
end
