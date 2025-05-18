# frozen_string_literal: true

module ApplicationHelper
  def human_date(date, format = :human)
    date ? I18n.l(date, format:) : t('time.no_value')
  end
end
