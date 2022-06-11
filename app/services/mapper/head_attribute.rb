module Mapper
  class HeadAttribute < Base
    map_attribute :CHID, RegexLibrary::WORD
    map_attribute :TITLE, RegexLibrary::WORD

    def call
      Head.create(title: title, chid: chid, validation_run: validation_run)
    end
  end
end
