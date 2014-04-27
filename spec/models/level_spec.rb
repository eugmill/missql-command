require 'spec_helper'

describe Level do

	describe "::load_from_yaml" do
		before(:each) do
			Level.load_from_yaml(File.expand_path("../../fixtures/test.yml", __FILE__))
			@level = Level.find_by(:stage_number => 99)
		end
		it "creates a new level from a YAML file" do
			expect(@level.title).to eq("Test")
		end
		it "creates a new level's pages from a YAML file" do
			expect(@level.level_pages).to_not be_empty
		end
		it "creates a new level's tests from a YAML file" do
			expect(@level.level_tests).to_not be_empty
		end
		it "creates a new level's schemata from a YAML file" do
			expect(@level.level_schemas).to_not be_empty
		end

	end

	describe "::update_from_yaml" do
		before(:each) do
			Level.load_from_yaml(File.expand_path("../../fixtures/test.yml", __FILE__))
			@level = Level.find_by(:stage_number => 99)
			Level.update_from_yaml(File.expand_path("../../fixtures/test_update.yml", __FILE__))
			@level.reload
		end
		it "updates an existing level from a YAML file" do
			expect(@level.title).to eq("Test 2")
		end
		it "creates a new level's pages from a YAML file" do
			expect(@level.level_pages.count).to eq(2)
		end
		it "creates a new level's tests from a YAML file" do
			expect(@level.level_tests.count).to eq(1)
		end
		it "creates a new level's schemata from a YAML file" do
			expect(@level.level_schemas.count).to eq(1)
			expect(@level.level_schemas.first.schema_columns.count).to eq(3)
		end

	end

	describe "instance methods" do

		before(:each) do
			Level.load_from_yaml(File.expand_path("../../fixtures/test.yml", __FILE__))
			@level = Level.find_by(:stage_number => 99)
		end

		describe "#correct_answer?" do
			let(:result){
				[{"test" => "test"}]
			}
			it "takes a pg result object and compares it to the correct answer" do
				expect(@level.correct_answer?(result)).to eq(true)
			end
		end

		describe "#ordered_pages" do
			it "returns the level pages in order" do
				expect(@level.ordered_pages).to_not be_empty
			end
		end

		describe "#prev_level" do
			it "gets the previous level if there is one" do
				expect(Level.find_by(:stage_number=>2).prev_level).to be_an_instance_of(Level)
			end
			it "returns an empty association if there is no previous level" do
				expect(@level.prev_level).to be_nil
			end
		end

		describe "#next_level" do
			it "gets the previous level if there is one" do
				expect(Level.find_by(:stage_number=>2).next_level).to  be_an_instance_of(Level)
			end
			it "returns an empty association if there is no previous level" do
				expect(@level.next_level).to be_nil
			end
		end
	end

	describe "#load_dump" do	
	
		before(:each) do
			@level = Level.new().tap{ |l|
				l.database_path = File.expand_path("../../fixtures/test.sql", __FILE__)
				l.stage_number = 99
				l.title = "Test Level"
				l.prompt = "Test prompt"
			}
		end
	
		it "loads the Level's tables from file" do
			@level.save
			expect(@level.dump).to eq(File.read(File.expand_path("../../fixtures/test.sql", __FILE__)))
		end

		it "is nil if the level's database_path is empty" do
			@level.database_path = ""
			expect(@level.dump).to eq(nil)
		end
	end
	
end