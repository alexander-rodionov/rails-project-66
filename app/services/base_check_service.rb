# frozen_string_literal: true

class BaseCheckService < BaseCustomService
  attr_accessor :dir, :result

  def self.checks_factory(languages)
    [
      languages.key?(:Ruby) ? RubyCheckService : nil,
      languages.key?(:JavaScript) ? EslintCheckService : nil
    ].compact
  end

  def initialize(dir)
    super()
    @dir = dir
  end

  def check
    stdout_res, _, status_res = run(check_command)
    return [true, nil] if status_res.success?

    parsed_data = JSON.parse(stdout_res)
    [false, parse_result(parsed_data)]
  rescue StandardError => e
    Rails.logger.error("Check job error: #{e}")
    register_rollbar_error(e)
    raise e
  end

  def parse_result(_)
    not_implemented_error
  end

  def self.language
    not_implemented_error
  end

  def check_command
    not_implemented_error
  end
end
