# frozen_string_literal: true

class CreateRepositories < ActiveRecord::Migration[7.0]
  def change
    create_table :repositories do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :full_name
      t.string :language
      t.integer :github_id

      t.timestamps
    end
  end
end
