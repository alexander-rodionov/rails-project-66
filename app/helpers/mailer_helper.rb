# frozen_string_literal: true

module MailerHelper
  def human_state(check)
    t("aasm.state_names.#{check.aasm_state}")
  end

  def human_date(date, format = :human)
    date ? I18n.l(date, format:) : t('time.no_value')
  end

  def error_count(check)
    check.result&.values&.reduce(0) { |a, v| a + check_error_count(v) }
  end

  def error_list(check)
    check.result&.transform_values do |check_result|
      next if check_result['success']

      offenses = filter_positive_offenses(check_result)
      offenses_array = extract_offense_values(offenses)
      offenses_array.sum([])
    end || {}
  end

  def filter_positive_offenses(check_result)
    check_result['result']['files'].filter { |v| v['offense_count'].positive? }
  end

  def extract_offense_values(offenses)
    offenses.map do |offense|
      [{ link: offense['file_name'] || 'unknown' }] + offense['offenses']
    end
  end

  def file_link(check, file_path)
    check.commit_id && "#{check.repository.web_path}/blob/#{check.commit_id}#{file_path}"
  end

  def git_commit_link(check)
    check.short_id && "#{check.repository.web_path}/commit/#{check.short_id}"
  end

  def check_error_count(check_item)
    check_item['success'] ? 0 : check_item['result']['summary']['offense_count']
  end
end
