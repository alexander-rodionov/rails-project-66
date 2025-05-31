# frozen_string_literal: true

class User < ApplicationRecord
  has_many :repository, dependent: :restrict_with_exception

  validates :email, presence: true, uniqueness: true
end
