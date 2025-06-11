# frozen_string_literal: true

class EslintCheckService < BaseCheckService
  def check_command
    ApplicationContainer.resolve(:command_launcher).eslint(dir)
  end

  def self.language
    'javascript'
  end

  def parse_result(in_data)
    result = {}
    result[:files] = in_data.map do |x|
      file_name = Rails.root.join(x['filePath']).to_s[dir.size..]
      offense_count = x['errorCount']
      offenses = x['messages'].map { |y| { rule: y['ruleId'], message: y['message'], location: "#{y['line']}:#{y['column']}" } }

      { file_name:, offense_count:, offenses: }
    end
    result[:summary] = {
      offense_count: result[:files].sum { |x| x[:offense_count] }, # reduce(0) { |a, x| a + x },
      target_file_count: result[:files].size,
      inspected_file_count: result[:files].size
    }
    result
  end
end
