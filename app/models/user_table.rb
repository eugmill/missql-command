class UserTable < ActiveRecord::Base
  belongs_to :user
  belongs_to :master_table
end
