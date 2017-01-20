require 'helper'

class TestField < Minitest::Test
  def setup
    @wheat = Wheat.new
    @field = Field.new
  end

  def test_wheat_harvest_time
    assert_equal(120, @wheat.harvest_time)
  end

  def test_grow_wheat
    @field.grow(@wheat)

    assert_equal(@wheat, @field.growing_crop)
    assert_equal(true, @field.occupied?)
  end

  def test_grow_set_occupied_at
    current_time = Time.now
    @field.grow(@wheat, current_time)

    assert_equal(current_time, @field.occupied_at)
  end

  def test_grow_occupied_field_raise_error
    @field.grow(@wheat)

    assert_raises FieldIsOccupiedException do
      @field.grow(@wheat)
    end
  end

  def test_harvest_blank_field
    assert_nil @field.harvest
  end

  def test_harvest_occupied_field_collectable
    # TODO: write `minute` helper
    grow_time = Time.now - 3*60

    @field.grow(@wheat, grow_time)
    assert_equal(HarvestItem, @field.harvest.class)
  end

  def test_harvest_occupied_field_before_available
    grow_time = Time.now

    @field.grow(@wheat, grow_time)
    assert_nil @field.harvest
  end
end
