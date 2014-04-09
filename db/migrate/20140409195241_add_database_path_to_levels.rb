class AddDatabasePathToLevels < ActiveRecord::Migration
  def change
    add_column :levels, :database_path, :string
  end
end
