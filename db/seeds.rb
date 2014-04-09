# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

level=Level.create(:title => "Development Level", :prompt => "Do what u want.", :stage_number => 1)
level.master_tables.create(:name => "dev_cities")

user1 = User.create(:user_name => "Test User", :email => "test@test.com", :password => "password", :password_confirmation => "password")