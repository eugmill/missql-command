# DBC=ActiveRecord::Base.connection

# def copy_table_for_user(table_name, user_id)
# 	new_table_name ="#{table_name}#{user_id}"
# 	clear_table_query = "DROP TABLE IF EXISTS #{new_table_name}"
# 	create_table_query = "CREATE TABLE #{new_table_name} AS SELECT * FROM #{table_name}"
# 	DBC.execute(clear_table_query)
# 	if DBC.execute(create_table_query)
# 		puts Time.now().to_s
# 		new_table_name
# 	else
# 		false
# 	end
# end