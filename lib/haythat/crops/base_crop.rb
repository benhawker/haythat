class BaseCrop
  def self.inherited(child_class)
    children_class << child_class
  end

  def self.children_class
    @@children_class ||= []
  end

  def self.minute(value)
    value * 60
  end

  HARVEST_TIME = minute(2)
  MAX_VALUE = 10

  # examine if can harvest crop
  def harvest?;end

  # an harvest product from crop
  def harvest;end

  #include HayThatHelper

  def initialize(options = {})
  end

  def harvest_time
    HARVEST_TIME
  end
end
