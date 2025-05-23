# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "info@#{ENV.fetch('BASE_URL', 'example.com')}"
  layout 'mailer'
end
