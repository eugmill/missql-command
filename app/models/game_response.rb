class GameResponse
  attr_accessor :user,:query
  def initialize(user,query)
    self.user = user
    self.query = query
  end

  def output
    @output ||= self.user.user_database.execute(self.query)
  end

  def correct?
    @correct ||= user.current_level.correct_answer?(output)
  end

  def result_array
    output.to_a
  end

  def full_errors
    #todo
  end

  def get_json
    
  end

end
