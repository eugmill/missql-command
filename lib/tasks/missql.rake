namespace :missql do
	desc "Drop and recreate the development level db"
	task :reset => :environment do
    User.destroy_all if ActiveRecord::Base.connection.table_exists? 'users'
		Rake::Task["db:drop"].invoke
		Rake::Task["db:create"].invoke
		Rake::Task["db:migrate"].invoke
		Rake::Task["db:seed"].invoke
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
  task :clean do
    20.times do |i|
      `dropdb user_database_#{Rails.env}_#{i}`
    end
  end

end