class GameSimulation
  INTERVAL = 0.5
  attr_reader :farm_activity, :command_engine

  def initialize(options = {})
    @farm_activity = options[:farm_activity]
    @command_engine = CommandEngine.new(farm_activity: @farm_activity)
  end

  def start
    command_listener_thread = Thread.new do
      loop do
          command_engine.listen
      end
    end

    game_loop do
      synchronize do
        command_engine.execute
      end
    end
  end

  def game_loop(&block)
    loop do
      block.call if block
      sleep INTERVAL
    end
  end

  def synchronize(&block)
    mutex.synchronize do
      block.call
    end
  end

  def mutex
    @_mutex ||= Mutex.new
  end
end
