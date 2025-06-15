# frozen_string_literal: true

module Api
  class ChecksController < Api::ApplicationController
    def create
      event_type = request.headers['X-GitHub-Event'] || 'push'
      case event_type
      when 'ping'
        head :ok
        Rails.logger.info("GitHub hook alive: #{params[:hook][:id]}")
      when 'push'
        repository_id = params[:repository][:id]
        repository = Repository.find_by(github_id: repository_id)

        if repository.nil?
          head :not_found
          return
        end

        @check = repository.checks.create!

        CheckRepositoryJob.perform_later(@check.id)
        head :ok
      end
    rescue StandardError => e
      register_rollbar_error(e)
      Rails.logger.error "Hook processing error #{e}"
    end
  end
end
