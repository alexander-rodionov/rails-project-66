# frozen_string_literal: true

class Repository::Check < ApplicationRecord
  include AASM
  belongs_to :repository

  if ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'
    attribute :result, :json, default: -> { {} }
  else
    serialize :result, coder: JSON
  end

  aasm do # aasm_state field
    state :created, initial: true
    state :finished, :failed

    event :end_processing do
      transitions to: :finished
    end

    event :fail do
      transitions to: :failed
    end
  end

  def short_id
    commit_id&.[](..6)
  end

  def passed?
    result&.values&.reduce(true) { |a, v| a && v['success'] } || false
  end
end
