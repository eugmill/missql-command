class Level < ActiveRecord::Base
  has_many :user_databases
  has_many :level_pages
  has_many :level_tests

  before_create :load_dump

  def load_dump
    self.dump = File.open(self.database_path) do |file|
      file.read
    end
    if !self.dump
      self.errors.add(:dump, "Could not load dump file")
    end
  end

  def self.load_from_yaml(path)
    config = YAML.load_file(path)
    new_level = Level.create(config["level"])

    config["level_pages"].each do |page|
      new_level.level_pages << LevelPage.new(page)
    end
  end

  def correct_answer?(result)
    self.answer == result.to_a.to_s
  end

  def ordered_pages
    self.level_pages.order(:page_number)
  end

  def next_level
    Level.find_by(:stage_number => (self.stage_number+1))
  end

end
