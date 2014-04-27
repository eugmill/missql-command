# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

require 'simplecov'
SimpleCov.start

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

require_relative 'support/wait_for_ajax.rb'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|

  config.include FactoryGirl::Syntax::Methods
  config.include Capybara::DSL
  config.include WaitForAjax, type: :feature

  # Database cleaner
  config.before(:suite) do
    `RAILS_ENV=test rake missql:clean_test_databases`
    `RAILS_ENV=test rake missql:reset`
  end

  config.after(:suite) do
    DatabaseCleaner.clean
    ActiveRecord::Base.remove_connection    
    `RAILS_ENV=test rake missql:clean_test_databases`
  end
  

  config.after(:each) do
    DatabaseCleaner.clean_with(:truncation)
    `RAILS_ENV=test rake missql:reload_all`
  end  

  config.use_transactional_fixtures = false

  config.infer_base_class_for_anonymous_controllers = false

  config.order = "default"
end
