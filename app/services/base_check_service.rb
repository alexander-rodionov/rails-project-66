# frozen_string_literal: true

class BaseCheckService < BaseCustomService
  attr_accessor :dir, :result

  def self.checks_factory(languages)
    [
      languages.include?('ruby') ? RubyCheckService : nil,
      languages.include?('javascript') ? EslintCheckService : nil
    ].compact
  end

  def initialize(dir)
    super()
    @dir = dir
  end

  def check
    stdout_res, _, status_res = check_command
    return [true, nil] if status_res.success?

    parsed_data = JSON.parse(stdout_res)
    [false, parse_result(parsed_data)]
  rescue StandardError => e
    Rails.logger.error("Check job error: #{e}")
    register_rollbar_error(e)
    raise e
  end

  def self.language
    not_implemented_error
  end

  def check_command
    not_implemented_error
  end

  def parse_result(in_data)
    {
      files: parse_files(in_data),
      summary: parse_summary(in_data)
    }
  end

  def parse_files(_in_data)
    not_implemented_error
  end

  def parse_summary(_in_data)
    not_implemented_error
  end
end
