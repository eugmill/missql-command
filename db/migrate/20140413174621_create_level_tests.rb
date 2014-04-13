class CreateLevelTests < ActiveRecord::Migration
  def change
    create_table :level_tests do |t|
      t.integer :level_id
      t.text :test_query
      t.text :expected_output
      t.string :error_message

      t.timestamps
    end
  end
end
