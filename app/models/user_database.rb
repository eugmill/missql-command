class UserDatabase < ActiveRecord::Base
	belongs_to :user
	after_create :create_user_database
  before_destroy :destroy_user_database

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
