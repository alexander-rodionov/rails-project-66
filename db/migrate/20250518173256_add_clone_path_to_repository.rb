# frozen_string_literal: true

class AddClonePathToRepository < ActiveRecord::Migration[7.0]
  def change
    add_column :repositories, :clone_path, :string
  end
end
