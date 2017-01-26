module Command
  class GrowCrop
    def initialize(args = [])
      @args = args
    end

    def call(farm_activity)
      field_index = @args[0].to_i
      crop_string = @args[1]

      field(farm_activity.fields, field_index)
        .grow(crop(crop_string))
    end

    def crop(crop_string)
      crops[crop_string].new
    end

    def field(fields, index)
      fields[index - 1]
    end

    def crops
      BaseCrop.children_class.inject({}) do |hash, class_name|
        hash[class_name.to_s.downcase] = class_name
        hash
      end
    end
  end
end
