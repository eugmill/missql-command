class RemoveCurrentTableFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :current_table, :string
  end
end
