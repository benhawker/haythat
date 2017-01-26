require 'helper'

class TestCommandGrowCrop < Minitest::Test
  def test_call
    fields = [Field.new]

    farm_activity = FarmActivity.new(fields: fields)

    command = Command::GrowCrop.new(["1", "wheat"])
    command.call(farm_activity)

    #puts fields.first.growing_crop
  end
end
