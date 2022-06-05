module Mapper
  class VentAttribute < Base
    map_attribute :SURF_ID, RegexLibrary::WORD

    def call
      Vent.create(surf_id: surf_id, validation_run: validation_run)
    end
  end
end
