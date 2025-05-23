# frozen_string_literal: true

class CheckMailer < ApplicationMailer
  include EmailHelpers
  helper EmailHelpers

  def started(check)
    return if check.nil?

    establish_fields(check)
    mail(to: @to_email, subject: t('email.started.header'))
  end

  def finished(check)
    return if check.nil?

    establish_fields(check)
    mail(to: @to_email, subject: t('email.finished.header'))
  end

  def establish_fields(check)
    @to_email = ENV.fetch('MAIL_CATCH_EMAIL', nil)
    @check = check
  end
end
