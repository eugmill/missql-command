class AddDumpsToLevels < ActiveRecord::Migration
  def change
    add_column :levels, :dump, :text
  end
end
