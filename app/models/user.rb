class User < ActiveRecord::Base
  # attr_accessible :email, :password, :password_confirmation
  has_secure_password
  validates_presence_of :password, :on => :create, :unless => :guest?
  validates_presence_of :email, :on => :create, :unless => :guest?
  has_many :user_levels, :dependent => :destroy
  has_many :levels, :through => :user_levels
  has_one :user_database, :dependent => :destroy

  validates_uniqueness_of :email, :user_name, :unless => :guest?

  after_create do 
  	self.user_database = UserDatabase.create(:name => "user_database_#{Rails.env}_#{self.id}")
  end

  

  def guest?
    self.guest
  end

  def load_level(level)
    self.user_database.load_level(level)
    unless self.levels.include?(level)
      self.levels << level
    end
  end

  def current_level
    return nil if !user_database
    self.user_database.level
  end

  def display_name
    user_name || email
  end

  def current_user_level
    self.user_levels.where(:level_id => current_level.id).first
  end

  def mark_current_complete
    current_user_level.update(:completed => true)
  end

  def has_completed?(level)
    return false unless has_started?(level)
    user_levels.where(:level_id => level.id).first.completed? 
  end

  def has_started?(level)
    self.levels.include?(level)
  end
end
