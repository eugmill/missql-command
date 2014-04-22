class Level < ActiveRecord::Base
  has_many :user_databases
  has_many :level_pages, :dependent => :destroy
  has_many :level_tests, :dependent => :destroy
  has_many :level_schemas, :dependent => :destroy
  has_many :user_levels, :dependent => :destroy

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
    new_level.load_yaml(path)
  end

  def self.update_from_yaml(path)
    config = YAML.load_file(path)
    level = find_by(:stage_number => config["level"]["stage_number"])
    level.update(config["level"])
    level.load_yaml(path) if level
  end

  def load_yaml(path)
    config = YAML.load_file(path)
    level_pages.destroy_all

    config["level_pages"].each do |page|
      level_pages << LevelPage.new(page)
    end

    self.default_text = config["default_text"]

    if config["level_tests"]
      level_tests.destroy_all
      config["level_tests"].each do |test|
        level_tests << LevelTest.new(test)
      end
    end

    if config["level_schemas"]
      level_schemas.destroy_all
      config["level_schemas"].each do |schema|
        new_schema = level_schemas.create(:table_name=> schema["table_name"])
          schema["schema_columns"].each do |column|
            new_schema.schema_columns << SchemaColumn.new(column)
          end
      end
    end

    save
  end

  def correct_answer?(result)
    self.answer == result.to_a.to_s
  end

  def ordered_pages
    self.level_pages.order(:page_number)
  end

  def prev_level
    Level.find_by(:stage_number => (self.stage_number-1))
  end

  def next_level
    Level.find_by(:stage_number => (self.stage_number+1))
  end

end
