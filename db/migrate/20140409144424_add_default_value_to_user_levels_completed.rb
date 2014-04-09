class AddDefaultValueToUserLevelsCompleted < ActiveRecord::Migration
  def up
  	change_column :user_levels, :completed, :boolean, :default => false
  end
  def down
  	change_column :user_levels, :completed, :boolean, nil
  end
end
