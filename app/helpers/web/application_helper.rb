# frozen_string_literal: true

module Web
  module ApplicationHelper
    def bootstrap_alert_class(flash_type)
      case flash_type.to_sym
      when :success then 'success'
      when :error, :alert then 'danger'
      when :notice then 'info'
      else 'primary'
      end
    end

    def user_present?
      controller.current_user.present?
    end

    def current_user_email
      controller.current_user[:email] || 'Unknown'
    end

    def human_state(check)
      t("aasm.state_names.#{check.aasm_state}")
    end
  end
end
