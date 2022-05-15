class SurfaceAttributeMapper
  def self.call(raw_attributes)
    new(raw_attributes).call
  end

  attr_reader :raw_attributes

  def initialize(raw_attributes)
    @raw_attributes = raw_attributes
  end

  def call
    Surface.create(volume_flow: volume_flow, char_id: char_id)
  end

  private

  def volume_flow
    raw_attributes.match(Regexp.new(/VOLUME_FLOW=/.source + RegexLibrary::REAL_NUMBER.source))[:value]
  end

  def char_id
    raw_attributes.match(Regexp.new(/ID=/.source + RegexLibrary::WORD.source))[:value]
  end
end
