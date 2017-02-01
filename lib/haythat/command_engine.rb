class CommandEngine
  COMMAND_SEPERATOR = " ".freeze

  FARM_ACTIVITY_COMMANDS = {
    "grow_crop" => Command::GrowCrop,
    "gcrop" => Command::GrowCrop
  }.freeze

  UTILITY_COMMANDS = {
    "display" => Command::Display
  }

  def initialize(options = {})
    @farm_activity = options[:farm_activity]
  end

  # Handler of command
  #
  # Validate if command is valid
  # Put command to command stack
  def listen
    command = gets

    command_name, *args = command.split(COMMAND_SEPERATOR)

    if FARM_ACTIVITY_COMMANDS.key?(command_name)
      command_object = build_farm_command(command_name, args)
    elsif UTILITY_COMMANDS.key?(command_name)
      command_object = build_utility_command(command_name, args)
    end

    commands.push command_object
  end

  def build_utility_command(command_name, command_args)
    UTILITY_COMMANDS[command_name].new(command_args, farm_activity: @farm_activity)
  end

  def build_farm_command(command_name, command_args)
    FARM_ACTIVITY_COMMANDS[command_name].new(command_args, farm_activity: @farm_activity)
  end

  def execute(args = {})
    _poped_command = commands.pop
    _poped_command.call if _poped_command
  end

  def commands
    @_command_queue ||= CommandQueue.new
  end
end
