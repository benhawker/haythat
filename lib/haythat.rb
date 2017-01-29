$LOAD_PATH << File.expand_path("./")

def autoload(path)
  if path[-1] != "/"
    path << "/"
  end

  Dir[File.dirname(__FILE__) + path + "*.rb"].each {|file| require file }
end

require "haythat/field"
require "haythat/farm_activity"

# require all crops
autoload "/haythat/crops"

# require command
autoload "/haythat/commands"
require "haythat/command_engine"

require "haythat/harvest_item"

require "haythat/exceptions/field_is_occupied_exception"

require "haythat/game_simulation"
