class MasterTable < ActiveRecord::Base
  belongs_to :level
  has_many :user_tables
end
