class NamelistFactory
  MODEL_MAPPING = {
    "SURF" => SurfaceAttributeMapper,
    "VENT" => VentAttributeMapper,
    "SLCF" => SliceFileAttributeMapper
  }

  def self.call(namelist_tuple)
    [MODEL_MAPPING.fetch(namelist_tuple.name, NoneMapper), namelist_tuple]
  end
end
