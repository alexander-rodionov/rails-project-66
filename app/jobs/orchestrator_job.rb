# frozen_string_literal: true

class OrchestratorJob < ApplicationJob
  def perform(trigger_clean_up: false)
    load_tasks do |tasks|
      Rails.logger.info("Available checks count: #{tasks.size}")
      tasks.each do |check|
        check_id = check[0]
        check_state = check[1]
        case check_state
        when 'created'
          process_created_status(check_id)
        when 'cloned'
          process_cloned_status(check_id)
        end
      end
    end

    CleanUpRepoJob.perform_later if trigger_clean_up
  rescue StandardError => e
    logger.error "OrchestratorJob failed\n #{e}"
    register_rollbar_error(e)
  end

  def process_created_status(check_id)
    if IMMEDIATE_START
      CloneRepositoryJob.perform_now(check_id)
    else
      CloneRepositoryJob.perform_later(check_id)
    end
  end

  def load_tasks
    if IMMEDIATE_START
      yield planned_checks while planned_checks(reload: true).any?
    else
      yield planned_checks
    end
  end

  def process_cloned_status(check_id)
    if IMMEDIATE_START
      PerformCheckJob.perform_now(check_id)
    else
      PerformCheckJob.perform_later(check_id)
    end
  end

  def planned_checks(reload: false)
    if reload || @planned_checks.nil?
      @planned_checks = Repository::Check.where(aasm_state: %w[created cloned]).pluck(:id, :aasm_state)
    end
    @planned_checks
  end
end
