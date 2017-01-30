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

  alias_method :pop, :take_first
end
