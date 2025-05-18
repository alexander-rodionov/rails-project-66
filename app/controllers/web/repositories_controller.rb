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
      debugger
      Repository.create!(
        user: current_user,
        name: 'Some name',
        full_name: 'Some_full_name',
        language: 'lang',
        github_id: @github_id
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
