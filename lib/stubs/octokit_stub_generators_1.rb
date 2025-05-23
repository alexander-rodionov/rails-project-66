# frozen_string_literal: true

module Stubs
  module OctokitStubGenerators1
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
        gravatar_id: '', url: "https://api.github.com/users/#{login}",
        html_url: "https://github.com/#{login}",
        followers_url: "https://api.github.com/users/#{login}/followers",
        type: 'User', site_admin: [true, false].sample,
        name: [Faker::Name.name, nil].sample, company: [Faker::Company.name, nil].sample,
        blog: [Faker::Internet.url, ''].sample, location: [Faker::Address.city, nil].sample,
        email: [Faker::Internet.email, nil].sample, hireable: [true, false, nil].sample,
        bio: [Faker::Lorem.paragraph(sentence_count: 2), nil].sample,
        twitter_username: [Faker::Internet.username(specifier: 3..15, separators: %w[_]), nil].sample,
        public_repos: Faker::Number.between(from: 0, to: 100), public_gists: Faker::Number.between(from: 0, to: 50),
        followers: Faker::Number.between(from: 0, to: 1000), following: Faker::Number.between(from: 0, to: 500),
        created_at: created_at, updated_at: updated_at, private_gists: Faker::Number.between(from: 0, to: 20),
        total_private_repos: Faker::Number.between(from: 0, to: 50), owned_private_repos: Faker::Number.between(from: 0, to: 50),
        disk_usage: Faker::Number.between(from: 1000, to: 1_000_000), collaborators: Faker::Number.between(from: 0, to: 20),
        two_factor_authentication: [true, false].sample, plan: {
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
          id: Faker::Number.unique.number(digits: 9),
          node_id: "R_kgDO#{SecureRandom.hex(6).upcase}",
          name: repo_name, full_name: "#{owner}/#{repo_name}", private: [true, false].sample,
          owner: {
            login: owner, id: Faker::Number.number(digits: 8),
            node_id: "MDQ6VXNlcj#{SecureRandom.hex(4).upcase}",
            avatar_url: "https://avatars.githubusercontent.com/u/#{Faker::Number.number(digits: 8)}?v=4",
            gravatar_id: '', url: "https://api.github.com/users/#{owner}",
            html_url: "https://github.com/#{owner}",
            type: %w[User Organization].sample,
            site_admin: [true, false].sample
          },
          html_url: "https://github.com/#{owner}/#{repo_name}",
          description: [Faker::Lorem.sentence, nil].sample,
          fork: [true, false].sample,
          url: "https://api.github.com/repos/#{owner}/#{repo_name}",
          forks_url: "https://api.github.com/repos/#{owner}/#{repo_name}/forks",
          keys_url: "https://api.github.com/repos/#{owner}/#{repo_name}/keys{/key_id}",
          created_at: created_at, updated_at: updated_at,
          pushed_at: pushed_at, git_url: "git://github.com/#{owner}/#{repo_name}.git",
          ssh_url: "git@github.com:#{owner}/#{repo_name}.git",
          clone_url: "https://github.com/#{owner}/#{repo_name}.git",
          svn_url: "https://github.com/#{owner}/#{repo_name}",
          homepage: [Faker::Internet.url, nil].sample,
          size: Faker::Number.between(from: 1000, to: 100_000),
          stargazers_count: Faker::Number.between(from: 0, to: 10_000),
          watchers_count: Faker::Number.between(from: 0, to: 5000),
          language: %w[Ruby JavaScript Python CSS HTML Java Go Rust Swift].sample,
          has_issues: [true, false].sample,   has_projects: [true, false].sample,
          has_downloads: true, has_wiki: [true, false].sample,
          has_pages: [true, false].sample, has_discussions: [true, false].sample,
          forks_count: Faker::Number.between(from: 0, to: 1000),
          mirror_url: nil, archived: [true, false].sample,
          disabled: [true, false].sample,
          open_issues_count: Faker::Number.between(from: 0, to: 100),
          license: [nil, {
            key: 'mit',  name: 'MIT License', spdx_id: 'MIT',
            url: 'https://api.github.com/licenses/mit', node_id: 'MDc6TGljZW5zZTEz'
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
            admin: [true, false].sample, maintain: [true, false].sample,
            push: [true, false].sample, triage: [true, false].sample,
            pull: true
          }
        }
      ]
    end
  end
end
