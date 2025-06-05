# frozen_string_literal: true

CLEAN_UP_INTERVAL = 10
SLEEP_INTERVAL = 2

if Rails.env.test?
  FILTER_REPOS_BY_ID = ->(repos, _) { repos[0] }
  CHECK_REGISTERED_HOOKS = ->(hooks) { hooks.any? }
  IMMEDIATE_START = true
  STATUS_FALLBACK = true
else
  FILTER_REPOS_BY_ID = ->(repos, repo_id) { (repos.filter { |r| r[:id] == repo_id })[0] }
  CHECK_REGISTERED_HOOKS = ->(_) { true }
  IMMEDIATE_START = false
  STATUS_FALLBACK = false
end
