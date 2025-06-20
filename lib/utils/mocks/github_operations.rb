# frozen_string_literal: true

# rubocop:disable Metrics/ClassLength
module Utils
  module Mocks
    module GithubOperations
      class Client
        def initialize(token); end

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

        def create_hook(*_args)
          generate_fake_github_hooks_response
        end

        def commits(*_args)
          [generate_fake_github_commit]
        end

        private

        def generate_fake_github_user
          login = Faker::Internet.unique.username(specifier: 5..15)
          id = Faker::Number.unique.number(digits: 8)
          created_at = Faker::Date.between(from: '2010-01-01', to: Time.zone.today).iso8601
          updated_at = Faker::Date.between(from: created_at, to: Time.zone.today).iso8601

          {
            login: login,
            id: id,
            node_id: "MDQ6VXNlcj#{SecureRandom.hex(6).upcase}",
            avatar_url: "https://avatars.githubusercontent.com/u/#{id}?v=4",
            gravatar_id: '',
            url: "https://api.github.com/users/#{login}",
            html_url: "https://github.com/#{login}",
            followers_url: "https://api.github.com/users/#{login}/followers",
            following_url: "https://api.github.com/users/#{login}/following{/other_user}",
            gists_url: "https://api.github.com/users/#{login}/gists{/gist_id}",
            starred_url: "https://api.github.com/users/#{login}/starred{/owner}{/repo}",
            subscriptions_url: "https://api.github.com/users/#{login}/subscriptions",
            organizations_url: "https://api.github.com/users/#{login}/orgs",
            repos_url: "https://api.github.com/users/#{login}/repos",
            events_url: "https://api.github.com/users/#{login}/events{/privacy}",
            received_events_url: "https://api.github.com/users/#{login}/received_events",
            type: 'User',
            site_admin: [true, false].sample,
            name: [Faker::Name.name, nil].sample,
            company: [Faker::Company.name, nil].sample,
            blog: [Faker::Internet.url, ''].sample,
            location: [Faker::Address.city, nil].sample,
            email: [Faker::Internet.email, nil].sample,
            hireable: [true, false, nil].sample,
            bio: [Faker::Lorem.paragraph(sentence_count: 2), nil].sample,
            twitter_username: [Faker::Internet.username(specifier: 3..15, separators: %w[_]), nil].sample,
            public_repos: Faker::Number.between(from: 0, to: 100),
            public_gists: Faker::Number.between(from: 0, to: 50),
            followers: Faker::Number.between(from: 0, to: 1000),
            following: Faker::Number.between(from: 0, to: 500),
            created_at: created_at,
            updated_at: updated_at,
            private_gists: Faker::Number.between(from: 0, to: 20),
            total_private_repos: Faker::Number.between(from: 0, to: 50),
            owned_private_repos: Faker::Number.between(from: 0, to: 50),
            disk_usage: Faker::Number.between(from: 1000, to: 1_000_000),
            collaborators: Faker::Number.between(from: 0, to: 20),
            two_factor_authentication: [true, false].sample,
            plan: {
              name: %w[free pro business].sample,
              space: Faker::Number.between(from: 1_000_000, to: 1_000_000_000),
              collaborators: Faker::Number.between(from: 0, to: 100),
              private_repos: Faker::Number.between(from: 0, to: 10_000)
            }
          }
        end

        def generate_fake_github_repo(owner_login = nil)
          owner = owner_login || Faker::Internet.unique.username(specifier: 5..15)
          repo_name = Faker::App.name.downcase.tr(' ', '-')
          created_at = Faker::Date.between(from: '2010-01-01', to: Time.zone.today).iso8601
          updated_at = Faker::Date.between(from: created_at, to: Time.zone.today).iso8601
          pushed_at = Faker::Date.between(from: updated_at, to: Time.zone.today).iso8601

          [
            {
              id: 345,
              node_id: "R_kgDO#{SecureRandom.hex(6).upcase}",
              name: repo_name,
              full_name: "#{owner}/#{repo_name}",
              private: [true, false].sample,
              owner: {
                login: owner,
                id: Faker::Number.number(digits: 8),
                node_id: "MDQ6VXNlcj#{SecureRandom.hex(4).upcase}",
                avatar_url: "https://avatars.githubusercontent.com/u/#{Faker::Number.number(digits: 8)}?v=4",
                gravatar_id: '',
                url: "https://api.github.com/users/#{owner}",
                html_url: "https://github.com/#{owner}",
                followers_url: "https://api.github.com/users/#{owner}/followers",
                following_url: "https://api.github.com/users/#{owner}/following{/other_user}",
                gists_url: "https://api.github.com/users/#{owner}/gists{/gist_id}",
                starred_url: "https://api.github.com/users/#{owner}/starred{/owner}{/repo}",
                subscriptions_url: "https://api.github.com/users/#{owner}/subscriptions",
                organizations_url: "https://api.github.com/users/#{owner}/orgs",
                repos_url: "https://api.github.com/users/#{owner}/repos",
                events_url: "https://api.github.com/users/#{owner}/events{/privacy}",
                received_events_url: "https://api.github.com/users/#{owner}/received_events",
                type: %w[User Organization].sample,
                site_admin: [true, false].sample
              },
              html_url: "https://github.com/#{owner}/#{repo_name}",
              description: [Faker::Lorem.sentence, nil].sample,
              fork: [true, false].sample,
              url: "https://api.github.com/repos/#{owner}/#{repo_name}",
              forks_url: "https://api.github.com/repos/#{owner}/#{repo_name}/forks",
              keys_url: "https://api.github.com/repos/#{owner}/#{repo_name}/keys{/key_id}",
              collaborators_url: "https://api.github.com/repos/#{owner}/#{repo_name}/collaborators{/collaborator}",
              teams_url: "https://api.github.com/repos/#{owner}/#{repo_name}/teams",
              hooks_url: "https://api.github.com/repos/#{owner}/#{repo_name}/hooks",
              issue_events_url: "https://api.github.com/repos/#{owner}/#{repo_name}/issues/events{/number}",
              events_url: "https://api.github.com/repos/#{owner}/#{repo_name}/events",
              assignees_url: "https://api.github.com/repos/#{owner}/#{repo_name}/assignees{/user}",
              branches_url: "https://api.github.com/repos/#{owner}/#{repo_name}/branches{/branch}",
              tags_url: "https://api.github.com/repos/#{owner}/#{repo_name}/tags",
              blobs_url: "https://api.github.com/repos/#{owner}/#{repo_name}/git/blobs{/sha}",
              git_tags_url: "https://api.github.com/repos/#{owner}/#{repo_name}/git/tags{/sha}",
              git_refs_url: "https://api.github.com/repos/#{owner}/#{repo_name}/git/refs{/sha}",
              trees_url: "https://api.github.com/repos/#{owner}/#{repo_name}/git/trees{/sha}",
              statuses_url: "https://api.github.com/repos/#{owner}/#{repo_name}/statuses/{sha}",
              languages_url: "https://api.github.com/repos/#{owner}/#{repo_name}/languages",
              stargazers_url: "https://api.github.com/repos/#{owner}/#{repo_name}/stargazers",
              contributors_url: "https://api.github.com/repos/#{owner}/#{repo_name}/contributors",
              subscribers_url: "https://api.github.com/repos/#{owner}/#{repo_name}/subscribers",
              subscription_url: "https://api.github.com/repos/#{owner}/#{repo_name}/subscription",
              commits_url: "https://api.github.com/repos/#{owner}/#{repo_name}/commits{/sha}",
              git_commits_url: "https://api.github.com/repos/#{owner}/#{repo_name}/git/commits{/sha}",
              comments_url: "https://api.github.com/repos/#{owner}/#{repo_name}/comments{/number}",
              issue_comment_url: "https://api.github.com/repos/#{owner}/#{repo_name}/issues/comments{/number}",
              contents_url: "https://api.github.com/repos/#{owner}/#{repo_name}/contents/{+path}",
              compare_url: "https://api.github.com/repos/#{owner}/#{repo_name}/compare/{base}...{head}",
              merges_url: "https://api.github.com/repos/#{owner}/#{repo_name}/merges",
              archive_url: "https://api.github.com/repos/#{owner}/#{repo_name}/{archive_format}{/ref}",
              downloads_url: "https://api.github.com/repos/#{owner}/#{repo_name}/downloads",
              issues_url: "https://api.github.com/repos/#{owner}/#{repo_name}/issues{/number}",
              pulls_url: "https://api.github.com/repos/#{owner}/#{repo_name}/pulls{/number}",
              milestones_url: "https://api.github.com/repos/#{owner}/#{repo_name}/milestones{/number}",
              notifications_url: "https://api.github.com/repos/#{owner}/#{repo_name}/notifications{?since,all,participating}",
              labels_url: "https://api.github.com/repos/#{owner}/#{repo_name}/labels{/name}",
              releases_url: "https://api.github.com/repos/#{owner}/#{repo_name}/releases{/id}",
              deployments_url: "https://api.github.com/repos/#{owner}/#{repo_name}/deployments",
              created_at: created_at,
              updated_at: updated_at,
              pushed_at: pushed_at,
              git_url: "git://github.com/#{owner}/#{repo_name}.git",
              ssh_url: "git@github.com:#{owner}/#{repo_name}.git",
              clone_url: "https://github.com/#{owner}/#{repo_name}.git",
              svn_url: "https://github.com/#{owner}/#{repo_name}",
              homepage: [Faker::Internet.url, nil].sample,
              size: Faker::Number.between(from: 1000, to: 100_000),
              stargazers_count: Faker::Number.between(from: 0, to: 10_000),
              watchers_count: Faker::Number.between(from: 0, to: 5000),
              language: 'Ruby',
              has_issues: [true, false].sample,
              has_projects: [true, false].sample,
              has_downloads: true,
              has_wiki: [true, false].sample,
              has_pages: [true, false].sample,
              has_discussions: [true, false].sample,
              forks_count: Faker::Number.between(from: 0, to: 1000),
              mirror_url: nil,
              archived: [true, false].sample,
              disabled: [true, false].sample,
              open_issues_count: Faker::Number.between(from: 0, to: 100),
              license: [nil, {
                key: 'mit',
                name: 'MIT License',
                spdx_id: 'MIT',
                url: 'https://api.github.com/licenses/mit',
                node_id: 'MDc6TGljZW5zZTEz'
              }].sample,
              allow_forking: true,
              is_template: [true, false].sample,
              web_commit_signoff_required: [true, false].sample,
              topics: Array.new(Faker::Number.between(from: 0, to: 5)).map { Faker::App.unique.name.downcase.tr(' ', '-') },
              visibility: %w[public private].sample,
              forks: Faker::Number.between(from: 0, to: 1000),
              open_issues: Faker::Number.between(from: 0, to: 100),
              watchers: Faker::Number.between(from: 0, to: 5000),
              default_branch: %w[main master develop].sample,
              permissions: {
                admin: [true, false].sample,
                maintain: [true, false].sample,
                push: [true, false].sample,
                triage: [true, false].sample,
                pull: true
              }
            }
          ]
        end

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
                name: author_login,
                email: Faker::Internet.email(name: author_login),
                date: commit_date
              },
              committer: {
                name: author_login,
                email: Faker::Internet.email(name: author_login),
                date: commit_date
              },
              message: Faker::Lorem.sentence,
              tree: {
                sha: SecureRandom.hex(20),
                url: "https://api.github.com/repos/#{repo_full_name}/git/trees/#{SecureRandom.hex(20)}"
              },
              url: "https://api.github.com/repos/#{repo_full_name}/git/commits/#{sha}",
              comment_count: Faker::Number.between(from: 0, to: 5),
              verification: {
                verified: false,
                reason: 'unsigned',
                signature: nil,
                payload: nil,
                verified_at: nil
              }
            },
            url: "https://api.github.com/repos/#{repo_full_name}/commits/#{sha}",
            html_url: "https://github.com/#{repo_full_name}/commit/#{sha}",
            comments_url: "https://api.github.com/repos/#{repo_full_name}/commits/#{sha}/comments",
            author: {
              login: author_login,
              id: Faker::Number.number(digits: 8),
              node_id: "MDQ6VXNlcj#{SecureRandom.hex(4).upcase}",
              avatar_url: "https://avatars.githubusercontent.com/u/#{Faker::Number.number(digits: 8)}?v=4",
              gravatar_id: '',
              url: "https://api.github.com/users/#{author_login}",
              html_url: "https://github.com/#{author_login}",
              followers_url: "https://api.github.com/users/#{author_login}/followers",
              following_url: "https://api.github.com/users/#{author_login}/following{/other_user}",
              gists_url: "https://api.github.com/users/#{author_login}/gists{/gist_id}",
              starred_url: "https://api.github.com/users/#{author_login}/starred{/owner}{/repo}",
              subscriptions_url: "https://api.github.com/users/#{author_login}/subscriptions",
              organizations_url: "https://api.github.com/users/#{author_login}/orgs",
              repos_url: "https://api.github.com/users/#{author_login}/repos",
              events_url: "https://api.github.com/users/#{author_login}/events{/privacy}",
              received_events_url: "https://api.github.com/users/#{author_login}/received_events",
              type: 'User',
              site_admin: [true, false].sample
            },
            committer: {
              login: author_login,
              id: Faker::Number.number(digits: 8),
              node_id: "MDQ6VXNlcj#{SecureRandom.hex(4).upcase}",
              avatar_url: "https://avatars.githubusercontent.com/u/#{Faker::Number.number(digits: 8)}?v=4",
              gravatar_id: '',
              url: "https://api.github.com/users/#{author_login}",
              html_url: "https://github.com/#{author_login}",
              followers_url: "https://api.github.com/users/#{author_login}/followers",
              following_url: "https://api.github.com/users/#{author_login}/following{/other_user}",
              gists_url: "https://api.github.com/users/#{author_login}/gists{/gist_id}",
              starred_url: "https://api.github.com/users/#{author_login}/starred{/owner}{/repo}",
              subscriptions_url: "https://api.github.com/users/#{author_login}/subscriptions",
              organizations_url: "https://api.github.com/users/#{author_login}/orgs",
              repos_url: "https://api.github.com/users/#{author_login}/repos",
              events_url: "https://api.github.com/users/#{author_login}/events{/privacy}",
              received_events_url: "https://api.github.com/users/#{author_login}/received_events",
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
            id: hook_id,
            name: 'web',
            active: active,
            events: events,
            config: {
              url: "https://rails66-back-rodionovalex.amvera.io/webhooks/#{SecureRandom.hex(10)}",
              content_type: 'json',
              insecure_ssl: '0',
              secret: '********' # GitHub always masks secrets in responses
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
  end
end

# rubocop:enable Metrics/ClassLength
