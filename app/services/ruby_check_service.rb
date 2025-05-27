# frozen_string_literal: true

class RubyCheckService < BaseCheckService
  def check_command
    "rubocop --force-default-config --format json #{dir}"
  end

  def self.language
    'ruby'
  end

  def parse_result(in_data)
    result = {
      summary: {
        offense_count: in_data['summary']['offense_count'],
        target_file_count: in_data['summary']['target_file_count'],
        inspected_file_count: in_data['summary']['inspected_file_count']
      },
      metadata: {
        rubocop_version: in_data['metadata'].map { |k, v| { k.to_sym => v } }.reduce(:merge)
      }
    }
    result[:files] = in_data['files'].map do |x|
      file_name = Rails.root.join(x['path']).to_s[dir.size..]
      offense_count = x['offenses'].size
      offenses = x['offenses'].map { |y| { message: y['message'], rule: y['cop_name'], location: "#{y['location']['start_line']}:#{y['location']['start_column']}" } }
      { file_name:, offense_count:, offenses: }
    end
    result
  end
end
