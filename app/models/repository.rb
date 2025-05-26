# frozen_string_literal: true

class Repository < ApplicationRecord
  belongs_to :user
  has_many :checks, dependent: :destroy

  validates :github_id, presence: true

  def last_check_status
    checks.order(created_at: :desc).first&.passed&.to_s || 'false'
  end
end
