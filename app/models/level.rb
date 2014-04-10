class Level < ActiveRecord::Base
  has_many :user_databases

  before_create :load_dump

  def load_dump
    self.dump = File.open(self.database_path) do |file|
      file.read
    end
    if !self.dump
      self.errors.add(:dump, "Could not load dump file")
    end
  end

  def correct_answer?(result)
    self.answer == result.to_a.to_s
  end

end
