# frozen_string_literal: true

class RubyCheckService < BaseCheckService
  def check_command
    ApplicationContainer.resolve(:command_launcher).rubocop(dir)
  end

  def self.language
    'ruby'
  end

  def parse_files(in_data)
    in_data['files'].map do |x|
      file_name = Rails.root.join(x['path']).to_s[dir.size..]
      offense_count = x['offenses'].size
      offenses = x['offenses'].map { |y| { message: y['message'], rule: y['cop_name'], location: compose_location(y) } }
      { file_name:, offense_count:, offenses: }
    end
  end

  def compose_location(offense)
    "#{offense['location']['start_line']}:#{offense['location']['start_column']}"
  end

  def parse_summary(in_data)
    {
      summary: {
        offense_count: in_data['summary']['offense_count'],
        target_file_count: in_data['summary']['target_file_count'],
        inspected_file_count: in_data['summary']['inspected_file_count']
      },
      metadata: {
        rubocop_version: in_data['metadata'].map { |k, v| { k.to_sym => v } }.reduce(:merge)
      }
    }
  end
end
