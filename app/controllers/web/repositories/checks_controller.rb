# frozen_string_literal: true

module Web
  module Repositories
    class ChecksController < Web::ApplicationController
      before_action :set_repository, only: :create
      before_action :set_check, only: :show

      attr_reader :check

      def show; end

      def create
        @check = @repository.checks.create!
        CloneJob.perform_later(@check.id)
        redirect_to repository_path(@repository)
      end

      private

      def set_repository
        @repository = Repository.find(params.require(:repository_id).to_i)
      end

      def set_check
        @check = Repository::Check.find(params.require(:id).to_i)
      end
    end
  end
end
