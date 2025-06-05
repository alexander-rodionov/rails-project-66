# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "info@#{ENV.fetch('BASE_URL', 'http://example.com')[%r{http.*://(.*)}, 1]}"
  layout 'mailer'
  helper :mailer
end
