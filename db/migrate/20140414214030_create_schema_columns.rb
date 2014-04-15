class CreateSchemaColumns < ActiveRecord::Migration
  def change
    create_table :schema_columns do |t|
      t.integer :level_schema_id
      t.string :column_name
      t.string :column_type

      t.timestamps
    end
  end
end
