#Load levels
Dir.glob('db/levels/*.yml') do |yml_file|
  Level.load_from_yaml(yml_file)
end

#Create test users
test_user = User.create(
  :user_name => "Test User",
  :email => "test@test.com",
  :password => "test",
  :password_confirmation => "test"
)
test_user_2 = User.create(
  :user_name => "Test User 2",
  :email => "test2@test.com",
  :password => "test",
  :password_confirmation => "test"
)
