module Mapper
  class SliceFileAttribute < Base
    map_attribute :PBX, RegexLibrary::REAL_NUMBER
    map_attribute :PBY, RegexLibrary::REAL_NUMBER
    map_attribute :PBZ, RegexLibrary::REAL_NUMBER
    map_attribute :QUANTITY, RegexLibrary::WORD
    map_attribute :VECTOR, RegexLibrary::LOGICAL

    def call
      SliceFile.create(pbx: pbx, pby: pby, pbz: pbz, quantity: quantity, vector: RegexLibrary.cast_logical(vector), validation_run: validation_run)
    end
  end
end
