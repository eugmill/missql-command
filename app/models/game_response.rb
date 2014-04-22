class GameResponse
  attr_accessor :user,:query
  def initialize(user,query)
    self.user = user
    self.query = query
  end

  def output_hash
    @output_hash ||= self.user.user_database.execute(self.query, self.user.current_level)
  end

  def correct?
    output_hash[:correct]
  end

  def type
    if output_hash[:output].class == PG::Result && output_hash[:output].to_a.length > 0
      "table"
    else 
      "string"
    end
  end

  def json    
    {
      :query => self.query,
      :response => {
        :display_type => type,
        :correct => output_hash[:correct],
        :errors => output_hash[:errors],
        :result => output_hash[:output]
      }
    }
  end

end
