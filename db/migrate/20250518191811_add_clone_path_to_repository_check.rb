# frozen_string_literal: true

class AddClonePathToRepositoryCheck < ActiveRecord::Migration[7.0]
  def change
    add_column :repository_checks, :clone_path, :string
    if ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'
      add_column :repository_checks, :result, :jsonb, default: {}
    else
      add_column :repository_checks, :result, :text
    end
  end
end
