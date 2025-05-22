# frozen_string_literal: true

module Repository
  class Check < ApplicationRecord
    include AASM
    belongs_to :repository

    if ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'
      self.ignored_columns += ['result'] if Rails.gem_version >= Version.new('7.1')
      attribute :result, :json, default: -> { {} }
    else
      serialize :result, coder: JSON
    end

    aasm do # aasm_state field
      state :created, initial: true
      state :cloning, :cloned, :processing, :finished, :failed, :emtpy

      event :start_clone do
        transitions from: :created, to: :cloning
      end

      event :end_clone do
        transitions from: :cloning, to: :cloned
      end

      event :skip_clone do
        transitions from: :created, to: :cloned
      end

      event :start_processing do
        transitions from: :cloned, to: :processing
      end

      event :no_checks do
        transitions from: :cloned, to: :empty
      end

      event :end_processing do
        transitions from: :processing, to: :finished
      end

      event :fail do
        transitions from: :created, to: :failed
        transitions from: :cloning, to: :failed
        transitions from: :cloned, to: :failed
        transitions from: :processing, to: :failed
      end
    end

    def short_id
      commit_id&.[](..6)
    end

    def error_count
      result&.values&.reduce(0) { |a, v| a + check_error_count(v) }
    end

    def check_error_count(check_item)
      check_item['success'] ? 0 : check_item['result']['summary']['offense_count']
    end

    def error_list
      result&.transform_values do |check_result|
        next if check_result['success']

        offenses = filter_positive_offenses(check_result)
        offenses_array = extract_offense_values(offenses)
        offenses_array.reduce([]) { |a, v| a + v }
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

    def commit_link
      "#{repository.web_path}/commit/#{short_id}"
    end

    def file_link(file_path)
      commit_id && "#{repository.web_path}/blob/#{commit_id}#{file_path}"
    end

    def passed?
      result&.values&.reduce(true) { |a, v| a && v['success'] } || false
    end
  end
end
