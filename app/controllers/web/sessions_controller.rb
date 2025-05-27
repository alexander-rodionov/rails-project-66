# frozen_string_literal: true

module Web
  class SessionsController < Web::ApplicationController
    def create
      email, nickname, token = extract_auth_values

      if email.nil? || nickname.nil? || token.nil?
        Rails.logger.debug 'FAILURE'
        Rails.logger.debug email, nickname, token
      end

      user = User.find_by(email: email)
      user ||= User.create!(nickname:, email:, token:)
      session[:user_id] = user.id
      redirect_to root_path, notice: t('message.logged_in')
    end

    def extract_auth_values
      [
        extract_auth_values_email,
        extract_auth_values_name,
        extract_auth_values_token
      ]
    end

    def extract_auth_values_email
      auth_hash&.[]('info')&.[]('email')
    end

    def extract_auth_values_name
      auth_hash&.[]('info')&.[]('nickname') || auth_hash&.[]('info')&.[]('name') || 'Unnamed'
    end

    def extract_auth_values_token
      auth_hash&.[]('credentials')&.[]('token')
    end

    def auth; end

    def destroy
      session[:user_id] = nil
      redirect_to root_path, notice: t('message.logged_out')
    end

    protected

    def auth_hash
      if Rails.env.development?
        request.env['omniauth.auth'] = {
          'provider' => 'developer',
          'uid' => '12345',
          'info' => {
            'email' => ENV.fetch('DEV_GIT_EMAIL'),
            'nickname' => ENV.fetch('DEV_GIT_NICKNAME')
          },
          'credentials' => {
            'token' => ENV.fetch('DEV_GIT_TOKEN', 'token')
          }
        }
      end
      request.env['omniauth.auth']
    end
  end
end
