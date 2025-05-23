# frozen_string_literal: true

module Web
  module RepositoriesHelper
    LANGUAGES = %w[Ruby JavaScript].freeze
    def available_projects
      all_repos = GitService.new(controller.current_user)
                            .repos
                            .filter { |r| LANGUAGES.include? r[:language] }
                            .map { |r| [r[:name], r[:id]] }
      assigned_repos = controller.current_user.repository.pluck(:github_id)
      all_repos&.filter { |r| assigned_repos.exclude?(r[1]) }&.sort { |a, b| a[0] <=> b[0] }
    end
  end
end
