namespace :missql do
	desc "Drop and recreate the development level db"
	task :reset => :environment do
		User.destroy_all
		Rake::Task["db:drop"].invoke
		Rake::Task["db:create"].invoke
		Rake::Task["db:migrate"].invoke
		Rake::Task["db:seed"].invoke
	end

end