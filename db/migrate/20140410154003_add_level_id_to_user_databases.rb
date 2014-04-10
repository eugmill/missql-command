class AddLevelIdToUserDatabases < ActiveRecord::Migration
  def change
    add_column :user_databases, :level_id, :integer
  end
end
