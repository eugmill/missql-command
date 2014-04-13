class CreateLevelPages < ActiveRecord::Migration
  def change
    create_table :level_pages do |t|
      t.integer :level_id
      t.integer :page_number
      t.text :content

      t.timestamps
    end
  end
end
