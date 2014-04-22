class LevelTest < ActiveRecord::Base
  belongs_to :level

  def pg_correct?(pgresult)
  	self.send(self.test_query, self.expected_output, pgresult.to_a)
  end

  def has_col?(expected, tuples)
      tuples.all?{|t| t.keys.include?(expected)}
  end

  def has_col_count?(expected, tuples)
  	return false if tuples.empty?
  	tuples[0].keys.count == expected.to_i
  end

  def has_row?(expected, tuples)
  	tuples.include?(eval(expected))
  end

  def has_row_count?(expected, tuples)
  	tuples.count == expected.to_i
  end

end
