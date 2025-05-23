# frozen_string_literal: true

class AddUrlsToRepository < ActiveRecord::Migration[7.2]
  def change
    add_column :repositories, :commits_path, :string
    add_column :repositories, :hooks_path, :string
  end
end
