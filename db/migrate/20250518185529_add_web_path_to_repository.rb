class AddWebPathToRepository < ActiveRecord::Migration[8.0]
  def change
    add_column :repositories, :web_path, :string
  end
end
