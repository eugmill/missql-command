class UserDatabase < ActiveRecord::Base
	belongs_to :user
	after_create :create_user_database
  before_destroy :destroy_user_database
  belongs_to :level

  def connection
  	@connection ||= PG.connect(:dbname => self.name)
  end
  
  def execute(query)
  	begin
  		connection.transaction do |conn|
  			begin
          @last_result=conn.exec(query)
        rescue PG::Error => e
          @last_result = e
        end
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
    self.save
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
