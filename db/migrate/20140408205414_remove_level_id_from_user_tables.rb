class RemoveLevelIdFromUserTables < ActiveRecord::Migration
  def change
    remove_column :user_tables, :level_id, :integer
  end
end
