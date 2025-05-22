# frozen_string_literal: true

module Web
  module RepositoriesHelper
    def available_projects
      all_repos = GitService.new(controller.current_user)
                            .repos
                            .filter { |r| %w[Ruby JavaScript].include? r[:language] }
                            .map { |r| [r[:name], r[:id]] }
      assigned_repos = controller.current_user.repository.pluck(:github_id)
      all_repos.filter { |r| assigned_repos.exclude?(r[1]) }.sort { |a, b| a[0] <=> b[0] }
    end

    def git_commit_link(check)
      check.short_id && "#{check.repository.web_path}/commit/#{check.short_id}"
    end
  end
end
