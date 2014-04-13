class AddLevelTypeToLevels < ActiveRecord::Migration
  def change
    add_column :levels, :level_type, :string
  end
end
