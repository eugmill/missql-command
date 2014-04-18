class AddDefaultTextToLevels < ActiveRecord::Migration
  def change
    add_column :levels, :default_text, :text
  end
end
