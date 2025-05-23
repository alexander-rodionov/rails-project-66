# frozen_string_literal: true

module Stubs
  module OctokitStubGenerators2
    def generate_fake_languages
      { Ruby: 16_362, Shell: 131, Makefile: 29 }
    end

    def generate_fake_github_commit
      author_login = Faker::Internet.unique.username(specifier: 5..15)
      repo_name = Faker::App.name.downcase.tr(' ', '-')
      repo_full_name = "#{author_login}/#{repo_name}"
      commit_date = Faker::Time.between(from: 1.year.ago, to: Time.zone.now).iso8601
      sha = SecureRandom.hex(20)
      parent_sha = SecureRandom.hex(20)

      {
        sha: sha,
        node_id: "C_kwDO#{SecureRandom.hex(10).upcase}",
        commit: {
          author: {
            name: author_login,  email: Faker::Internet.email(name: author_login),  date: commit_date
          },
          committer: {
            name: author_login,  email: Faker::Internet.email(name: author_login),  date: commit_date
          },
          message: Faker::Lorem.sentence,
          tree: {
            sha: SecureRandom.hex(20),
            url: "https://api.github.com/repos/#{repo_full_name}/git/trees/#{SecureRandom.hex(20)}"
          },
          url: "https://api.github.com/repos/#{repo_full_name}/git/commits/#{sha}",
          comment_count: Faker::Number.between(from: 0, to: 5),
          verification: {
            verified: false, reason: 'unsigned', signature: nil, payload: nil, verified_at: nil
          }
        },
        url: "https://api.github.com/repos/#{repo_full_name}/commits/#{sha}",
        html_url: "https://github.com/#{repo_full_name}/commit/#{sha}",
        comments_url: "https://api.github.com/repos/#{repo_full_name}/commits/#{sha}/comments",
        author: {
          login: author_login, id: Faker::Number.number(digits: 8), node_id: "MDQ6VXNlcj#{SecureRandom.hex(4).upcase}",
          avatar_url: "https://avatars.githubusercontent.com/u/#{Faker::Number.number(digits: 8)}?v=4",
          gravatar_id: '', url: "https://api.github.com/users/#{author_login}",
          html_url: "https://github.com/#{author_login}", type: 'User', site_admin: [true, false].sample
        },
        committer: {
          login: author_login, id: Faker::Number.number(digits: 8), node_id: "MDQ6VXNlcj#{SecureRandom.hex(4).upcase}",
          avatar_url: "https://avatars.githubusercontent.com/u/#{Faker::Number.number(digits: 8)}?v=4",
          gravatar_id: '',
          url: "https://api.github.com/users/#{author_login}",
          html_url: "https://github.com/#{author_login}",
          type: 'User',
          site_admin: [true, false].sample
        },
        parents: [
          {
            sha: parent_sha,
            url: "https://api.github.com/repos/#{repo_full_name}/commits/#{parent_sha}",
            html_url: "https://github.com/#{repo_full_name}/commit/#{parent_sha}"
          }
        ]
      }
    end

    def generate_fake_github_hooks_response
      owner = Faker::Internet.unique.username(specifier: 5..15)
      repo = Faker::App.name.downcase.tr(' ', '-')

      hook_id = Faker::Number.unique.number(digits: 8)
      events = %w[push pull_request].sample(2)
      active = [true, false].sample
      [{
        id: hook_id, name: 'web', active: active, events: events,
        config: {
          url: "https://example.com/webhooks/#{SecureRandom.hex(10)}",
          content_type: 'json',
          insecure_ssl: '0'
        },
        updated_at: Faker::Time.between(from: 1.year.ago, to: Time.zone.now).iso8601,
        created_at: Faker::Time.between(from: 2.years.ago, to: 1.year.ago).iso8601,
        url: "https://api.github.com/repos/#{owner}/#{repo}/hooks/#{hook_id}",
        test_url: "https://api.github.com/repos/#{owner}/#{repo}/hooks/#{hook_id}/test",
        ping_url: "https://api.github.com/repos/#{owner}/#{repo}/hooks/#{hook_id}/pings",
        last_response: {
          code: [200, 404, 500].sample,
          status: %w[active inactive].sample,
          message: ['OK', 'Timeout', 'Service unavailable'].sample
        }
      }]
    end
  end
end
