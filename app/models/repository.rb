class Repository < ApplicationRecord
  belongs_to :user
  has_many :checks

  validates :github_id, presence: true

  def last_check_status
    checks.order(created_at: :desc).first&.passed&.to_s || 'false'
  end
end
