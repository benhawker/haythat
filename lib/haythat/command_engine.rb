class CommandEngine
  COMMAND_SEPERATOR = " ".freeze

  COMMANDS = {
    "grow_crop" => Command::GrowCrop,
    "gcrop" => Command::GrowCrop
  }.freeze

  def initialize(options = {})
    @farm_activity = options[:farm_activity]
  end

  # Handler of command
  #
  # Validate if command is valid
  # Put command to command stack
  def receive(command)
    command_name, *args = command.split(COMMAND_SEPERATOR)

    if COMMANDS.key?(command_name)
      commands.push(build_command(command_name, args))
    end
  end

  def build_command(command_name, command_arr)
    COMMANDS[command_name].new(command_arr)
  end

  def execute
    first_command = commands.take_first
  end

  def commands
    @_command_queue ||= CommandQueue.new
  end

  class CommandQueue
    def initialize
      @data = []
      @current_point = 0
    end

    def push(command)
      @data << command
    end

    def size
      @data.size
    end

    def take(num = 1)
      @data.shift(num)
    end

    def take_first
      take(1).first
    end
  end
end
