class ChangeMasterTablesTableNameToName < ActiveRecord::Migration
  def change
    rename_column :master_tables, :table_name, :name
  end
end
