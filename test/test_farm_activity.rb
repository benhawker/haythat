require 'helper'

class TestFarmActivity < Minitest::Test
  def build_fields(fields)
    fields.map do |field_hash|
      Field.new.tap do |field|
        field.grow(field_hash[:crop], field_hash[:time]) if field_hash[:crop]
      end
    end
  end

  def test_field_collection
    fields = [Field.new]

    farm_activity = FarmActivity.new(fields: fields)
    assert_equal(1, farm_activity.fields.size)
  end

  def test_add_more_field
    farm_activity = FarmActivity.new
    farm_activity.fields << Field.new
    assert_equal(1, farm_activity.fields.size)
  end

  def test_blank_fields
    field = Field.new

    farm_activity = FarmActivity.new(fields: [field])
    assert_equal(field, farm_activity.blank_fields.first)
  end

  def test_collectable_fields
    fields = build_fields([
      {crop: Wheat.new, time: Time.now},
      {}
    ])

    farm_activity = FarmActivity.new(fields: fields)
    assert_equal(fields[0], farm_activity.collectable_fields.first)
  end

  def test_harvest_fields
    fields = build_fields([
      {
        crop: Wheat.new, time: Time.now - 4 * 60
      }
    ])

    farm_activity = FarmActivity.new(fields: fields)
    assert_equal(HarvestItem, farm_activity.harvest(fields[0]).first.class)
  end

  def test_harvest_blank_field
    field1 = Field.new
    farm_activity = FarmActivity.new(fields: [field1])

    assert_equal(0, farm_activity.harvest(field1).size)
  end

  def test_harvest_field_before_harvest_time
    fields = build_fields([
      {crop: Wheat.new, time: Time.now}
    ])

    farm_activity = FarmActivity.new(fields: fields)

    assert_equal(0, farm_activity.harvest(fields[0]).size)
  end

  def test_harvest_multiple_fields
    fields = build_fields([
      {
        crop: Wheat.new, time: Time.now - 4 * 60
      },
      {
        crop: Wheat.new, time: Time.now - 4 * 60
      },
      {},
      {
        crop: Wheat.new, time: Time.now
      },
    ])

    farm_activity = FarmActivity.new(fields: fields)

    assert_equal(2, farm_activity.harvest(*fields).size)
  end
end
