level_1 = Level.create(:title => "Paris is Burning", :prompt => "Find out how many people will die by selecting the population of Paris.", :database_path =>"db/dumps/lvl1.sql", :stage_number=> 1)
test_user = User.create(:user_name => "Test User", :email => "test@test.com", :password => "test", :password_confirmation => "test")
test_user.user_database.load_level(level_1)

level_2 = Level.create(:title => "Shoot down the nuke about to kill your family!", :prompt => "Find out the strength of Tsar Bomba", :database_path =>"db/dumps/lvl2.sql", :stage_number=> 2)
test_user_2 = User.create(:user_name => "Test User 2", :email => "test2@test.com", :password => "test", :password_confirmation => "test")
test_user_2.user_database.load_level(level_2)