class LevelTest < ActiveRecord::Base
  belongs_to :level

def test_pg(pgresult)
	self.send(self.test_query, self.expected_output, pgresult.to_a)
end

def has_col(expected, tuples)
    tuples.all?{|t| t.keys.include?(expected)}
end

def has_only_cols(expected, tuples)
	tuples.all?{|t| t.keys - %w(expected) == 0}
end

def has_only_col(expected, tuples)
    tuples.all?{|t| t.keys.length == 1 && t.keys.include?(expected)}
end

def has_row(expected, tuples)
	tuples.include?(eval(expected))
end

def has_only_row(expected, tuples)
	tuples.length == 1 && has_row(expected, tuples)
end

def is_record(expected, tuples)
	tuples[0] == eval(expected)
end

def has_enough_rows(expected, tuples)
	tuples.count == expected.to_i
end

end
