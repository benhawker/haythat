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
    _command = command.split(COMMAND_SEPERATOR)
    command_name = _command[0]
    args = _command[1..-1]

    if COMMANDS.key?(command_name)
      commands.push(command_name, args)
    end
  end

  def execute
    first_command = commands.take_first
    command_name, args = first_command
  end

  def commands
    @_command_queue ||= CommandQueue.new
  end

  class CommandQueue
    def initialize
      @data = []
      @current_point = 0
    end

    def push(command_name, args)
      @data << { command_name => args }
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
