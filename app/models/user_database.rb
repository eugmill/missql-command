class UserDatabase < ActiveRecord::Base
	belongs_to :user
	after_create :create_user_database
  before_destroy :destroy_user_database
  has_one :level

  def connection
  	@connection ||= PG.connect(:dbname => self.name)
  end
  
  def execute(query)
  	begin
  		connection.transaction do |conn|
  			@last_result=conn.exec(query)
  			raise RollbackFlag
  		end
  	rescue RollbackFlag
  		@last_result
  	end
  end

  def load_level(level)
  	empty_self
  	commands = level.dump
  	connection.exec(commands)
    self.level = level
  end

  def empty_self
  	connection.exec("DROP SCHEMA public CASCADE; CREATE SCHEMA public;")
  end

private
  def destroy_user_database
    `dropdb #{self.name}`
  end

  def create_user_database
	`createdb #{self.name}`
  end

class RollbackFlag < StandardError
end

end
