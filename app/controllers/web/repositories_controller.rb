# frozen_string_literal: true

module Web
  class RepositoriesController < Web::ApplicationController
    before_action :set_github_id, only: :create
    before_action :set_repository, only: :show

    def index
      @repositories = Repository.where(user: current_user)
    end

    def new
      @repository = Repository.new
    end

    def create
      gs = GitService.new(current_user)
      repo = gs.repo_by_id(@github_id)
      Repository.create!(
        user: current_user,
        name: repo[:name],
        full_name: repo[:full_name],
        language: gs.primary_language(repo[:id]),
        github_id: repo[:id],
        web_path: repo[:html_url],
        clone_path: repo[:clone_url]
      )
      redirect_to repositories_path
    end

    def show; end

    private

    def set_github_id
      @github_id = params.expect(repository: [:github_id])[:github_id].to_i
    end

    def set_repository
      @repository = Repository.find(params.expect(:id))
    end
  end
end
