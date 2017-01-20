class FarmActivity
  attr_accessor :fields

  def initialize(options = {})
    @fields = options[:fields] || []
  end

  def blank_fields
    fields.select { |field| !field.growing_crop }
  end

  def collectable_fields
    fields - blank_fields
  end

  def harvest(*fields)
    fields.map { |field| field.harvest }.compact
  end
end
