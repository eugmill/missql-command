class LevelSchema < ActiveRecord::Base
	belongs_to :level
	has_many :schema_columns, :dependent => :destroy	

end
