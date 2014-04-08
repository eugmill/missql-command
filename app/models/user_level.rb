class UserLevel < ActiveRecord::Base
  belongs_to :user
  has_one :level

end