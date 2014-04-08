class CreateUserTables < ActiveRecord::Migration
  def change
    create_table :user_tables do |t|
      t.string :table_name
      t.integer :user_id
      t.integer :level_id

      t.timestamps
    end
  end
end
