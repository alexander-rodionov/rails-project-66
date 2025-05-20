class AddErrorToRepositoryCheck < ActiveRecord::Migration[8.0]
  def change
    add_column :repository_checks, :error, :string
  end
end
