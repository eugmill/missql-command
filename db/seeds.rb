#Create test levels
level_1 = Level.create(:title => "Paris is Burning", 
  :prompt => "Find out how many people will die by selecting the population of Paris.", 
  :database_path =>"db/dumps/lvl1.sql", :stage_number=> 1, 
  :answer=>"[{\"population\"=>\"8000000\"}]",
  :type => "read" )
level_1.level_pages.build(:page_number => 1, :content => "Welcome to Missql Command! This is an interactive game to teach you SQL.")
level_1.level_pages.build(:page_number => 2, :content => "The first SQL lesson is on how to select data from a table.")
level_1.level_pages.build(:page_number => 3, :content => "A SELECT statement is how you pull specific data from a table. See the example below:")
level_1.save

level_2 = Level.create(:title => "Shoot down the nuke about to kill your family!", 
  :prompt => "Alter the strength of Tsar Bomba so it is 1 megaton", 
  :database_path =>"db/dumps/lvl2.sql", :stage_number=> 2, 
  :answer=>"[{\"1134000\"}]",
  :type => "write")
level_2.level_pages.build(:page_number => 1, :content => "You can also use SQL to change the values within tables.")
level_2.level_pages.build(:page_number => 2, :content => "Some more stuff.")
level_2.level_pages.build(:page_number => 3, :content => "Super duper lesson goes here.")
level_2.save

#Create test users
test_user = User.create(:user_name => "Test User", :email => "test@test.com", :password => "test", :password_confirmation => "test")
test_user.user_database.load_level(level_1)

test_user_2 = User.create(:user_name => "Test User 2", :email => "test2@test.com", :password => "test", :password_confirmation => "test")
test_user_2.user_database.load_level(level_2)