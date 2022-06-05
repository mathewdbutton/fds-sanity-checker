module Mapper
  class MiscAttribute < Base
    map_attribute :GVEC, RegexLibrary::REAL_ARRAY

    def call
      gvec_x, gvec_y, gvec_z = gvec_array
      Misc.create(gvec_x: gvec_x, gvec_y: gvec_y, gvec_z: gvec_z, validation_run: validation_run)
    end

    private

    def gvec_array
      gvec.split(",").map do | raw_value |
        next 0.0 if short_hand_zero(raw_value)
        BigDecimal(raw_value)
      end
    end

    def short_hand_zero(value)
      value == "0."
    end
  end
end
