module Mapper
  class SurfaceAttribute < Base
    map_attribute :VOLUME_FLOW, RegexLibrary::REAL_NUMBER
    map_attribute :ID, RegexLibrary::WORD

    def call
      Surface.create(volume_flow: volume_flow, char_id: id, validation_run: validation_run)
    end
  end
end
