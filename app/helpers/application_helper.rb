# frozen_string_literal: true

module ApplicationHelper
  def human_date(date, format = :human)
    date ? I18n.l(date, format:) : t('time.no_value')
  end

  def safe_url(url)
    uri = URI.parse(url)

    uri.to_s if uri.is_a?(URI::HTTP)
  rescue URI::InvalidURIError
    nil
  end
end
