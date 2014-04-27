namespace :missql do
	desc "Drop and recreate the development level db"
	task :reset => :environment do
    User.destroy_all if ActiveRecord::Base.connection.table_exists? 'users'
    `dropdb missql-command_#{Rails.env}`
		Rake::Task["db:create"].invoke
		Rake::Task["db:migrate"].invoke
	end

  desc "Updates all the levels from yaml files"
  
  task :update_all => :environment do
    Dir.glob('db/levels/*.yml') do |yml_file|
      Level.update_from_yaml(yml_file)
    end
  
  end

  desc "Reloads all the levels from their yaml files"
  task :reload_all => :environment do
    Level.destroy_all
    Dir.glob('db/levels/*.yml') do |yml_file|
      Level.load_from_yaml(yml_file)
    end
  end

  desc "Reload a single level"
  task :reload, [:num] => :environment do |t,args|
    Level.find_by(:stage_number => args[:num].to_i).destroy
    Level.load_from_yaml("db/levels/lvl#{args[:num]}.yml")
  end

  desc "Delete first 20 user_databases in a pretty hacky way. "
  task :clean => :environment do
    20.times do |i|
      `dropdb user_database_#{Rails.env}_#{i}`
    end
  end

  desc "Delete all guest users who have not logged in during the past 24 hours"
  task :scrub_guests => :environment do
    User.all.where(:guest => true).where("last_logged_in > ?", 1.day.ago).destroy_all
  end

  desc "Clean out all test databases"
  task :clean_test_databases do
    db_list = `psql -l`
    db_list
    matches = db_list.scan(/user_database_test_\d+/)
    matches.each do |match|
      `dropdb #{match}`
    end
  end

  task :kill_postgres_connections => :environment do
    20.times do |i|
      db_name = "user_database_#{Rails.env}_#{i}"
      sh = <<-EOF
      ps xa \
        | grep postgres: \
        | grep #{db_name} \
        | grep -v grep \
        | awk '{print $1}' \
        | xargs kill
      EOF
      `#{sh}`
    end
  end
end