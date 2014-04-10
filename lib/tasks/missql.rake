namespace :missql do
	desc "Drop and recreate the development level db"
	task :reset => :environment do
		User.destroy_all
		Rake::Task["db:drop"].invoke
		Rake::Task["db:create"].invoke
		Rake::Task["db:migrate"].invoke
		Rake::Task["db:seed"].invoke
	end

  desc "Delete first 20 user_databases in a pretty hacky way. "
  task :clean do
    50.times do |i|
      `dropdb user_database_#{i}`
    end
  end

end