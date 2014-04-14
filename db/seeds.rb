#Create test levels

Level.load_from_yaml("./db/levels/lvl1.yml")
Level.load_from_yaml("./db/levels/lvl2.yml")


level_1 = Level.find_by(:stage_number => 1);
level_2 = Level.find_by(:stage_number => 2);

#Create test users
test_user = User.create(:user_name => "Test User", :email => "test@test.com", :password => "test", :password_confirmation => "test")
test_user.user_database.load_level(level_1)

test_user_2 = User.create(:user_name => "Test User 2", :email => "test2@test.com", :password => "test", :password_confirmation => "test")
test_user_2.user_database.load_level(level_2)