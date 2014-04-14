#Create test levels

# level_1 = Level.create(:title => "Welcome to Missql Command!", 
#   :prompt => "Welcome to Missql Command! Write your first basic query.", 
#   :database_path =>"db/dumps/lvl1.sql", :stage_number=> 1, 
#   :answer=>"[{\"id\"=>\"1\", \"name\"=>\"New York\", \"population\"=>\"8337000\"}, {\"id\"=>\"2\", \"name\"=>\"Paris\", \"population\"=>\"2211000\"}, {\"id\"=>\"3\", \"name\"=>\"San Francisco\", \"population\"=>\"825000\"}, {\"id\"=>\"4\", \"name\"=>\"London\", \"population\"=>\"8308000\"}, {\"id\"=>\"5\", \"name\"=>\"Moscow\", \"population\"=>\"11500000\"}, {\"id\"=>\"6\", \"name\"=>\"Tokyo\", \"population\"=>\"13230000\"}, {\"id\"=>\"7\", \"name\"=>\"Shanghai\", \"population\"=>\"24000000\"}]",
#   :level_type => "read" )
# level_1.level_pages.build(:page_number => 1, :content => "<p>Hello Commander! Welcome to Missql Command! Your job is to defend the worlds cities from a missile attack, and learn some SQL along the way.</p><p>SQL is a language used to access a relational database. A relational database is composed of tables, which are similar to spreadsheets.</p>")
# level_1.level_pages.build(:page_number => 2, :content => "The first SQL lesson is on how to select data from a table.")
# level_1.level_pages.build(:page_number => 3, :content => "A SELECT statement is how you pull specific data from a table. See the example below:")
# level_1.save
Level.load_from_yaml("./db/levels/lvl1.yml")


# level_2 = Level.create(:title => "Shoot down the nuke about to kill your family!", 
#   :prompt => "Alter the strength of Tsar Bomba so it is 1 megaton", 
#   :database_path =>"db/dumps/lvl2.sql", :stage_number=> 2, 
#   :answer=>"[{\"1134000\"}]",
#   :level_type => "write")
# level_2.level_pages.build(:page_number => 1, :content => "You can also use SQL to change the values within tables.")
# level_2.level_pages.build(:page_number => 2, :content => "Some more stuff.")
# level_2.level_pages.build(:page_number => 3, :content => "Super duper lesson goes here.")

# level_2.level_tests.build(:test_query => "SELECT megatons from missiles where name ='Tsar Bomba';", :expected_output => "[{\"megatons\"=>\"1\"}]", :error_message => "Tsar Bomba is not the right strength. Try again.")
# level_2.level_tests.build(:test_query => "SELECT megatons from missiles where name ='Tsar Bomba';", :expected_output => "[{\"megatons\"=>\"1\"}]", :error_message => "Womp Womp. Try again.")

# level_2.save
Level.load_from_yaml("./db/levels/lvl2.yml")


level_1 = Level.find_by(:stage_number => 1);
level_2 = Level.find_by(:stage_number => 2);

#Create test users
test_user = User.create(:user_name => "Test User", :email => "test@test.com", :password => "test", :password_confirmation => "test")
test_user.user_database.load_level(level_1)

test_user_2 = User.create(:user_name => "Test User 2", :email => "test2@test.com", :password => "test", :password_confirmation => "test")
test_user_2.user_database.load_level(level_2)