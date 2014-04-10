level_1 = Level.create(:title => "Paris is Burning", :prompt => "Find out how many people will die by selecting the population of Paris.", :database_path =>"db/dumps/lvl1.sql", :stage_number=> 1)
test_user = User.create(:user_name => "Test User", :email => "test@test.com", :password => "test", :password_confirmation => "test")
test_user.user_database.copy_level(level_1)