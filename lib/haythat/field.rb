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
    HarvestItem.new(growing_crop) if harvestable?(current_time)
  end

  def harvestable?(current_time)
    growing_crop && occupied_at + growing_crop.harvest_time <= current_time
  end
end
