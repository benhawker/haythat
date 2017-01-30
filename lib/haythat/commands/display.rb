module Command
  class Display
    def initialize(args = [], options = {})
      @args = args
      @farm_activity = options[:farm_activity]
    end

    def call
      puts "----SUMMARY---"

      @farm_activity.fields.each_with_index do |field, index|
        printf "field\s%d:\s%-5s" % [ index, field.growing_crop ]
      end

      puts "\n------"
    end
  end
end
