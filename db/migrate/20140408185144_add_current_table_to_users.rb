class AddCurrentTableToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_table, :string
  end
end
