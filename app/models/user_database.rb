class UserDatabase < ActiveRecord::Base
	belongs_to :user
	after_create :create_user_database
  before_destroy :destroy_user_database
  belongs_to :level

  def connection
  	@connection ||= PG.connect(:dbname => self.name)
  end
  
  def execute(query, level)
    correct = true
    last_result = nil
    errors = []
    if level.level_type == "read"
  	begin
  		connection.transaction do |conn|
    			begin
            last_result=conn.exec(query)
            binding.pry
            correct = (level.correct_answer?(last_result)) 
            errors << "You selected the wrong rows. Take a closer look!" if !correct
          rescue PG::Error => e
            last_result = e.to_s
            correct = false            
          end
  			  raise RollbackFlag
    		end
  	rescue RollbackFlag
       {:correct => correct, :errors => errors, :output => last_result}
  	end

    elsif level.level_type == "write"
      begin
        connection.transaction do |conn|
        begin
          last_result=conn.exec(query)
          begin
            level.level_tests.each do |test|
              if test.expected_output != conn.exec(test.test_query).to_a.to_s
                errors << test.error_message
                correct = false
              end
            end
          rescue
            errors = ["You changed the table in an unexpected way. Try again!"]
            correct = false
          end
        rescue PG::Error => e
          last_result = e.to_s
          correct = false            
        end
          raise RollbackFlag
        end
      rescue RollbackFlag
         {:correct => correct, :errors => errors, :output => last_result}
      end
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
