# Examples
#
#   wheat = Wheat.new
#
#   field = Field.new
#   field.grow(wheat)
#   field.harvest? => false
#
#   field.grow(wheat) => raise FieldIsOccupied
#
#   # 2 minutes later
#   field.harvest? => true
#   field.harvest => HarvestItem(harvest_crop: wheat, quantity: 2)
#

class FieldIsOccupiedException < RuntimeError;end

class Field
  attr_reader :growing_crop, :occupied_at

  def grow(crop, time = Time.now)
    raise FieldIsOccupiedException if growing_crop

    @occupied_at = time
    @growing_crop = crop
  end

  def occupied?
    !!@growing_crop
  end

  def harvest(current_time = Time.now)
    if growing_crop && occupied_at + growing_crop.harvest_time <= current_time
      HarvestItem.new(growing_crop)
    end
  end
end
