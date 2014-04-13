class UserDatabase < ActiveRecord::Base
	belongs_to :user
	after_create :create_user_database
  before_destroy :destroy_user_database
  belongs_to :level

  def connection
  	@connection ||= PG.connect(:dbname => self.name)
  end
  
  def execute(query, level)
    correct = nil
    last_result = nil
  	begin
  		connection.transaction do |conn|
        # if level.type == "read"
    			begin
            last_result=conn.exec(query)
            correct = (level.correct_answer?(last_result)) 
            errors = "You selected the wrong rows. Take a closer look!" if !correct
          rescue PG::Error => e
            last_result = e.to_s
            correct = false            
          end
  			  raise RollbackFlag
    		end
      # end
  	rescue RollbackFlag
       {:correct => correct, :errors => errors, :output => last_result}
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
