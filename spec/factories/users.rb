FactoryGirl.define do
  factory :user do |n|
    email 'factory@girl.com'
    user_name 'factory_girl'
    password 'changeme'
    password_confirmation 'changeme'
  end
end
