# frozen_string_literal: true

require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class MockAuthStrategy < OmniAuth::Strategies::Developer
      def request_phase
        redirect callback_url
      end

      def callback_phase
        env['omniauth.auth'] = {
          'provider' => 'github',
          'uid' => '12345',
          'info' => {
            'email' => ENV.fetch('DEV_GIT_EMAIL'),
            'nickname' => ENV.fetch('DEV_GIT_NICKNAME')
          },
          'credentials' => {
            'token' => ENV.fetch('DEV_GIT_TOKEN', 'token')
          }
        }
        call_app!
      end
    end
  end
end
