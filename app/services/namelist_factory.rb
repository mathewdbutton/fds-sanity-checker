class NamelistFactory
  MODEL_MAPPING = {
    "SURF" => Mapper::SurfaceAttribute,
    "VENT" => Mapper::VentAttribute,
    "SLCF" => Mapper::SliceFileAttribute,
    "DEVC" => Mapper::DeviceAttribute,
    "MISC" => Mapper::MiscAttribute,
  }

  def self.call(namelist_tuple)
    [MODEL_MAPPING.fetch(namelist_tuple.name, NoneMapper), namelist_tuple]
  end
end
