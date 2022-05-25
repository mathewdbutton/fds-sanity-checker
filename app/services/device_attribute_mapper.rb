class DeviceAttributeMapper < BaseMapper
  map_attribute :QUANTITY, RegexLibrary::WORD
  map_attribute :ORIENTATION, RegexLibrary::REAL_TRIPLET
  map_attribute :ID, RegexLibrary::WORD

  def call
    Device.create(
        char_id: id,
        orientation: orientation,
        quantity: quantity,
        validation_run: validation_run
      )
  end
end
