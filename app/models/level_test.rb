class LevelTest < ActiveRecord::Base
  belongs_to :level

def test_pg(pgresult)
	self.send(self.test_query, self.expected_output, pgresult.to_a)
end

def has_col(expected, tuples)
    tuples.all?{|t| t.keys.include?(expected)}
end

def has_row(expected, tuples)
	tuples.include?(eval(expected))
end

def is_record(expected, tuples)
	tuples[0] == eval(expected)
end

def has_enough_rows(expected, tuples)
	tuples.count == expected.to_i
end

end
