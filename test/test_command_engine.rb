require 'helper'

class TestCommandEngine < Minitest::Test
  def setup
    @engine = CommandEngine.new
  end

  def test_put_command_to_stack
    command = "grow_crop 1 wheat"

    @engine.receive(command)
    assert_equal(1, @engine.commands.size)
  end

  def test_execute
    fields = [Field.new]
    farm_activity = FarmActivity.new(fields: fields)

    engine = CommandEngine.new(farm_activity: farm_activity)
    engine.receive("grow_crop 1 corn")

    engine.execute
  end
end

class TestCommandQueue < Minitest::Test
  def setup
    @command_queue = CommandEngine::CommandQueue.new
  end

  def test_push_command
    @command_queue.push(Command::GrowCrop.new(["1", "corn"]))
    assert_equal(1, @command_queue.size)
  end

  def test_take_1_command
    @command_queue.push(Command::GrowCrop.new(["1", "corn"]))
    @command_queue.push(Command::GrowCrop.new(["2", "wheat"]))
    assert_equal(1, @command_queue.take(1).size)
  end

end
