class GameSimulation
  attr_reader :command_engine
  attr_reader :farm_activity

  def initialize
    @command_engine = CommandEngine.new
    @farm_activity = FarmActivity.new
  end

  def start
    command_listener_thread = Thread.new do
      command_engine.listen
    end

    game_loop do
      command_engine.execute(farm_activity)
    end
  end
end

#---

class CommandEngine
  attr_reader :commands

  def initialize
    @commands = nil#...
    @farm_activity = farm_activity
  end

  def listen
    read_from_user_input do |raw_command|
      if valid?(raw_command)
        commands.add build_command(raw_command)
      end
    end
  end

  def execute
    #todo: in the future, a command may affect to other activities like animal feed, fishing, saling...
    #need to check type of command before passing a activity class
    _pop_command = commands.pop
    _pop_command.(farm_activity) if _pop_command
  end

  def read_from_user_input(&block)
    #todo
    block.call unless block
  end

  def valid?(raw_command)
    #todo
    false
  end

  def build_command(raw_command)
    #todo
    nil
  end
end

#---

class FarmActivity
  attr_reader :fields

  def initialize(options)
    @silo = options[:silo]
  end

  def grow(field_index, crop)
    #todo
  end

  def harvest(field_index)
    #todo
    # check if @silo is still available to put harvested crops into.
    # if @silo is full or just 1 less, harvest failed
  end
end

#---

class Field
  def grow(crop)
  end

  def harvest
  end
end

class Crop
end

class HarvestItem
end
