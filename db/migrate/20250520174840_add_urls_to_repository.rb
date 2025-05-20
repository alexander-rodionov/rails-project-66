class AddUrlsToRepository < ActiveRecord::Migration[8.0]
  def change
    add_column :repositories, :commits_path, :string
    add_column :repositories, :hooks_path, :string
  end
end
