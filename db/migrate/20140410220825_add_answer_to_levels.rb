class AddAnswerToLevels < ActiveRecord::Migration
  def change
    add_column :levels, :answer, :text
  end
end
