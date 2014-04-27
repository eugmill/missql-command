#Load levels
Dir.glob('db/levels/*.yml') do |yml_file|
  Level.load_from_yaml(yml_file)
end

