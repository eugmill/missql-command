class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.string :title
      t.text :prompt
      t.integer :stage_number

      t.timestamps
    end
  end
end
