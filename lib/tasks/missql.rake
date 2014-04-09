namespace :missql do

	task :db_methods => :environment do
		require_relative "./missql.rb"
	end
	task :db_test_env => :db_methods do
		require "benchmark"
	end

	desc "Create dev_cities table"
	task :create_dev_cities => :db_methods do
		DBC.execute("CREATE TABLE dev_cities (name VARCHAR(255), population INTEGER);")
	end

	desc "Populate the dev_cities table"
	task :populate_dev => :create_dev_cities do
		DBC.execute("INSERT INTO dev_cities VALUES ('New York', 9000000);")
		DBC.execute("INSERT INTO dev_cities VALUES ('Paris', 8000000);")
		DBC.execute("INSERT INTO dev_cities VALUES ('San Francisco', 825000);")
		DBC.execute("INSERT INTO dev_cities VALUES ('Moscow', 11000000);")
		DBC.execute("INSERT INTO dev_cities VALUES ('Tokyo', 13000000);")
	end

	desc "Spin up a temporary table for a user based on an existing table"
	task :clone, [:table_name, :user_id] => [:db_methods] do |t, args|
		puts Time.now().to_s
		user = User.find(args[:user_id])
		if user
			tableid = copy_table_for_user(args[:table_name], args[:user_id])
		else
			puts "Could not find user"
		end
		if tableid
			user.current_table = tableid
			if user.save
				puts "Successfully saved table to user."
			else
				puts "Couldn't save user"
			end
		else
			puts "Could not copy table."
		end
	end

	desc "Benchmark clone"
	task :benchmark_clone => :db_test_env do
		puts Benchmark.measure{
			user = User.find(1)
		if user
			tableid = copy_table_for_user("users", 1)
		else
			puts "Could not find user"
		end
		if tableid
			user.current_table = tableid
			if user.save
				puts "Successfully saved table to user."
			else
				puts "Couldn't save user"
			end
		else
			puts "Could not copy table."
		end
		}
	end

end