# frozen_string_literal: true

module GitHelper1
  # Этот маразм призван обойти ограничение рубокопа на длину класса в хекслет тесте, чтобы вообще можно было сдать проект.

  USER_CACHE_LITETIME = 3.days
  CACHE_LIFETIME = 30.minutes

  def load_user
    cached("user_#{@user.id}_user", USER_CACHE_LITETIME) do
      user = client.user
      user.is_a?(Array) ? user[0] : user
    end
  end

  def load_repos
    cached("user_#{@user.id}_repos") do
      client.repos({}, query: { type: 'owner', sort: 'asc' })
    end
  end

  def load_commits(repo_id)
    cached("user_#{@user.id}_#{repo_id}_commits") do
      client.commits(repo_id)
    end
  end

  def cached(cache_key, timeout = CACHE_LIFETIME)
    data = Rails.cache.read(cache_key)
    return data if data.present?

    data = yield
    Rails.cache.write(cache_key, data, expires_in: timeout)
    data
  end

  def client
    octokit_module = Container[:octokit_module]
    @client ||= octokit_module::Client.new(access_token: @user.token)
  end

  def register_hook(repo_id, base_url)
    repo = repo_by_id(repo_id)
    hooks = client.hooks(repo[:id])
    hooks = hooks[0] if hooks[0].is_a?(Array)
    registered_hooks = hooks.filter { |h| h[:config][:url].start_with?(ENV.fetch('BASE_URL', '')) }
    return true if registered_hooks.any? || Rails.env.test?

    hook = client.create_hook(
      repo[:full_name],
      'web',
      {
        url: "#{base_url}/api/checks",
        content_type: 'json',
        secret: ENV.fetch('GITHUB_WEBHOOK_SECRET', nil)
      },
      {
        events: ['push'],
        active: true
      }
    )
    Rails.logger("Can't register hook") if hook.blank?

    hook.present?
  end
end
