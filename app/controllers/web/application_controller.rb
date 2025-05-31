# frozen_string_literal: true

module Web
  class ApplicationController < ApplicationController
    allow_browser versions: :modern

    rescue_from Pundit::NotAuthorizedError, with: :handle_unauthorized

    private

    # Redirect unauthorized users to root with a flash message
    def handle_unauthorized(_)
      flash[:alert] = t('message.not_authorized')
      redirect_to root_path and return
    end
  end
end
