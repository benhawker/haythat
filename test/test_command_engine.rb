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
end

class TestCommandQueue < Minitest::Test
  def setup
    @command_queue = CommandEngine::CommandQueue.new
  end

  def test_push_command
    @command_queue.push("grow_crop", ["1", "wheat"])
    assert_equal(1, @command_queue.size)
  end

  def test_take_1_command
    @command_queue.push("grow_crop", ["1", "corn"])
    @command_queue.push("grow_crop", ["2", "indigo"])
    assert_equal(1, @command_queue.take(1).size)
  end
end
