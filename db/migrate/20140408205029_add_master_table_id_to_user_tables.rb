class AddMasterTableIdToUserTables < ActiveRecord::Migration
  def change
    add_column :user_tables, :master_table_id, :integer
  end
end
