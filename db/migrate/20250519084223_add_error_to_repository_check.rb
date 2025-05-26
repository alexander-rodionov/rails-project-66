# frozen_string_literal: true

class AddErrorToRepositoryCheck < ActiveRecord::Migration[7.0]
  def change
    add_column :repository_checks, :error, :string
  end
end
