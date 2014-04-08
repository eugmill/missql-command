class CreateMasterTables < ActiveRecord::Migration
  def change
    create_table :master_tables do |t|
      t.string :table_name
      t.integer :level_id

      t.timestamps
    end
  end
end
