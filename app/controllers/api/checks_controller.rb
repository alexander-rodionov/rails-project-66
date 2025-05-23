# frozen_string_literal: true

module Api
  class ChecksController < Api::ApplicationController
    def create
      repository_id = params[:repository][:id]
      repository = Repository.find_by(github_id: repository_id)

      head :not_found if repository.nil?

      check = repository.checks.create!
      CloneJob.perform_later(check.id)
      head :ok
    rescue StandardError => e
      register_rollbar_error(e)
      Rails.logger "Hook processing error #{e}"
    end
  end
end
