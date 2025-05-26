# frozen_string_literal: true

class AddWebPathToRepository < ActiveRecord::Migration[7.0]
  def change
    add_column :repositories, :web_path, :string
  end
end
