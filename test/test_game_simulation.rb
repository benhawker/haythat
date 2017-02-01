require 'helper'

class TestGameSimulation < Minitest::Test
  def test_start_with_one_field
    farm_activity = FarmActivity.new(fields: [Field.new] )
    gs = GameSimulation.new(farm_activity: farm_activity)

    #gs.start

    #assert_equal(false, farm_activity.fields.first.growing_crop == nil)
  end
end
