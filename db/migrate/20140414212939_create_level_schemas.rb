class CreateLevelSchemas < ActiveRecord::Migration
  def change
    create_table :level_schemas do |t|
      t.integer :level_id
      t.string :table_name
      t.timestamps
    end
  end
end
