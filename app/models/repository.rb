# frozen_string_literal: true

class Repository < ApplicationRecord
  extend Enumerize
  belongs_to :user
  has_many :checks, dependent: :destroy

  validates :github_id, presence: true, uniqueness: true

  enumerize :language, in: %i[ruby javascript]
end
