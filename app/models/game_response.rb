class GameResponse
  attr_accessor :user,:query
  def initialize(user,query)
    self.user = user
    self.query = query
  end

  def pg_output
    @pg_output ||= self.user.user_database.execute(self.query)
  end

  def correct?
    if error?
      false
    else
      @correct ||= user.current_level.correct_answer?(pg_output)
    end
  end

  def error?
    pg_output.class != PG::Result
  end

  def result_array
    if error?
      pg_output.to_s
    else
      pg_output.to_a
    end
  end

  def full_errors
    #todo
  end

  def get_json
    
  end

end
