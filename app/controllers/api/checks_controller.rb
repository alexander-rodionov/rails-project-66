# frozen_string_literal: true

module Api
  class ChecksController < Api::ApplicationController
    def create
      Rails.logger.debug params
      head :ok
    end
  end
end
