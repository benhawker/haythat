class GameSimulation
  attr_reader :farm_activity

  def initialize(options = {})
    @farm_activity = options[:farm_activity]
  end

  def start
    read_uinp
    display_value

    #run
  end

  def run
    loop do
      @farm_activity.harvest(*@farm_activity.collectable_fields)

      @farm_activity.blank_fields.each do |field|
        field.grow(rand_crop)
      end

      sleep 1
    end
  end

  def read_uinp
    #Thread.new { #TODO }
  end

  def synchronize(&block)
    mutex.synchronize do
      block.call
    end
  end

  def display_value
  end

  def mutex
    @_mutext ||= Mutex.new
  end

  def rand_crop
    [ Carrot, Corn, ChiliPeper, Indigo, Pumpkin, Soybean, Sugarcane, Wheat ].sample(1).first.new
  end

  def update
  end
end
