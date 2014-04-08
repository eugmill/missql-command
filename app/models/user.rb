class User < ActiveRecord::Base
  # attr_accessible :email, :password, :password_confirmation
  has_secure_password
  validates_presence_of :password, :on => :create
  has_many :user_levels
  has_many :levels, :through => :user_levels
  has_many :user_tables

end
