# frozen_string_literal: true

class Web::SessionsController < Web::ApplicationController
  def create
    pp auth_hash
    email = auth_hash['info']['email']
    nickname = auth_hash['info']['nickname']
    token = auth_hash['info']['credentials']['token']

    user = User.find_by(email: email)
    user ||= User.create!(nickname:, email:, token:)
    session[:user_id] = user.id
    redirect_to root_path, notice: t('message.logged_in')
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
        "provider" => 'developer',
        "uid" => '12345',
        'info' => {
          'email' => ENV.fetch('DEV_GIT_EMAIL'),
          'nickname' => ENV.fetch('DEV_GIT_NICKNAME'),
          'credentials' => {
            'token' => ENV.fetch('DEV_GIT_TOKEN')
          }
        }

      }
    end
    request.env['omniauth.auth']
  end
end
