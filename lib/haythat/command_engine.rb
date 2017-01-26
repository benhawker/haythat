class CommandEngine
  COMMAND_SEPERATOR = " ".freeze

  COMMANDS = {
    "grow_crop" => Command::GrowCrop,
    "gcrop" => Command::GrowCrop
  }.freeze

  attr_reader :commands

  def initialize(options = {})
  end

  # Handler of command
  #
  # Validate if command is valid
  # Put command to command stack
  # Execute command
  def receive(command)
    _command = command.split(COMMAND_SEPERATOR)
    command_name = _command[0]
    args = _command[1..-1]

    if COMMANDS.key?(command_name)
      commands.push(command_name, args)
    end
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
      took_commands = @data[@current_point...@current_point+num]
      @current_point += num
      took_commands
    end
  end
end
