# frozen_string_literal: true

class CreateRepositoryChecks < ActiveRecord::Migration[8.0]
  def change
    create_table :repository_checks do |t|
      t.references :repository, null: false, foreign_key: true
      t.text :aasm_state
      t.boolean :passed
      t.text :commit_id

      t.timestamps
    end
  end
end
