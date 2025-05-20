# frozen_string_literal: true

every 15.minutes do
  runner 'CleanUpRepoJob.perform_later'
end
