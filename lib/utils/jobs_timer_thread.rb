# frozen_string_literal: true

module Utils
  module JobsTimerThread
    def self.start
      Thread.new do
        Rails.logger.info 'Starting jobs timer thread'
        counter = 0
        loop do
          sleep SLEEP_INTERVAL
          begin
            OrchestratorJob.perform_later(trigger_clean_up: (counter % CLEAN_UP_INTERVAL).zero?)
            counter = (counter + 1) % CLEAN_UP_INTERVAL
          rescue StandardError => e
            Rails.logger.error "Jobs timer thread failed\n #{e}"
          end
        end
      end
    end
  end
end
